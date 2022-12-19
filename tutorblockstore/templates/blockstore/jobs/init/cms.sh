# Adapted from https://github.com/openedx/frontend-app-library-authoring/blob/26ea285dc2b5f0c32c6f1a9017a45c6add03f8d7/tutor-contrib-library-authoring-mfe/tutor_library_authoring_mfe/templates/library_authoring_mfe/tasks/cms/init
# 
# Create waffle switches to enable the Blockstore app that's now built into
# edx-platform, rather than requiring it to be installed and enabled separately.
(./manage.py cms waffle_switch --list | grep blockstore.use_blockstore_app_api) || ./manage.py lms waffle_switch --create blockstore.use_blockstore_app_api on
# Enable the waffle flag to use this MFE
(./manage.py cms waffle_flag --list | grep studio.library_authoring_mfe) || ./manage.py lms waffle_flag  studio.library_authoring_mfe --create --everyone
# Make sure a Blockstore "Collection" exists to hold the library content.
# This matches the development environment default of the MFE's BLOCKSTORE_COLLECTION_UUID setting:
# https://github.com/openedx/frontend-app-library-authoring/blob/b95c198b/.env.development#L20
echo "from blockstore.apps.bundles.models import Collection; coll, _ = Collection.objects.get_or_create(title='Dev Libraries Content Collection', uuid='11111111-2111-4111-8111-111111111111')" | ./manage.py cms shell