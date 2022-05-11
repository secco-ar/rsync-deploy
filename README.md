# rsync-deploy
Repositorio para implementar deploys mediante rsync

## Ejemplo de uso:

```yaml
      - name: rsync web files
        uses: secco-ar/rsync-deploy@main
        with:
          switches: -avzr
          remote_path: /var/www/html/<destino>
          remote_host: ${{ secrets.TEST_HOST }}
          remote_port: ${{ secrets.TEST_PORT }}
          remote_user: ${{ secrets.TEST_USER }}
          remote_key: ${{ secrets.TEST_DEPLOY_KEY }}
```
