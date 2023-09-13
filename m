Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D611779E5E8
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 13:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239930AbjIMLKy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 07:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239910AbjIMLKx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 07:10:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F72B19B0;
        Wed, 13 Sep 2023 04:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bX4iGfr0tDcuYF5EDBEIAqxef+8miCseN1a4MmuC19c=; b=g4OcufcLBW19o88tMTLEGrn/2M
        CLpqezXLQzOk/PYicTrYmwexiyk2JYuPbmISbHvegprAO28vD6/ovEfXYs0ZLIoR055SfeBNgbdjN
        veGb+NyDJ0TjumaKDjj04voay+g2iyGNDKkbHzas9ZSGb+Y5FjtoWgarnLhOBIz72Nykc/DZOau9I
        bNLLDErOdBxZbTTYG+HAPqeLOwTS2539I2l8NSiXnhbRm5hM6ZZsxCpOZsdn773njAtNPb1oabubo
        UEDBVo4lHgfnRUX6J2p6FtG40LeHJ0zURd1riXEq/Fw5RqsdMIGqe0EyYlKahq+W1lpCsWNjHdvOd
        inndOPjw==;
Received: from [190.210.221.22] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgNlV-005hwf-0G;
        Wed, 13 Sep 2023 11:10:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [PATCH 04/19] NFS: remove the s_dev field from struct nfs_server
Date:   Wed, 13 Sep 2023 08:09:58 -0300
Message-Id: <20230913111013.77623-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913111013.77623-1-hch@lst.de>
References: <20230913111013.77623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Don't duplicate the dev_t in the nfs_server structure given that it can
be trivially retrieved from the super_block.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/client.c           |  2 +-
 fs/nfs/nfs4proc.c         |  8 ++++----
 fs/nfs/nfs4trace.h        |  6 +++---
 fs/nfs/nfs4xdr.c          |  2 +-
 fs/nfs/super.c            | 10 +++-------
 include/linux/nfs_fs_sb.h |  1 -
 6 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 44eca51b28085d..039fd67ac17c82 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1337,7 +1337,7 @@ static int nfs_volume_list_show(struct seq_file *m, void *v)
 	clp = server->nfs_client;
 
 	snprintf(dev, sizeof(dev), "%u:%u",
-		 MAJOR(server->s_dev), MINOR(server->s_dev));
+		 MAJOR(server->super->s_dev), MINOR(server->super->s_dev));
 
 	snprintf(fsid, sizeof(fsid), "%llx:%llx",
 		 (unsigned long long) server->fsid.major,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 794343790ea8bb..4d002cc514983c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6763,7 +6763,7 @@ static int _nfs4_proc_getlk(struct nfs4_state *state, int cmd, struct file_lock
 		goto out;
 	lsp = request->fl_u.nfs4_fl.owner;
 	arg.lock_owner.id = lsp->ls_seqid.owner_id;
-	arg.lock_owner.s_dev = server->s_dev;
+	arg.lock_owner.s_dev = server->super->s_dev;
 	status = nfs4_call_sync(server->client, server, &msg, &arg.seq_args, &res.seq_res, 1);
 	switch (status) {
 		case 0:
@@ -7088,7 +7088,7 @@ static struct nfs4_lockdata *nfs4_alloc_lockdata(struct file_lock *fl,
 		goto out_free_seqid;
 	p->arg.lock_owner.clientid = server->nfs_client->cl_clientid;
 	p->arg.lock_owner.id = lsp->ls_seqid.owner_id;
-	p->arg.lock_owner.s_dev = server->s_dev;
+	p->arg.lock_owner.s_dev = server->super->s_dev;
 	p->res.lock_seqid = p->arg.lock_seqid;
 	p->lsp = lsp;
 	p->server = server;
@@ -7475,7 +7475,7 @@ nfs4_retry_setlk(struct nfs4_state *state, int cmd, struct file_lock *request)
 		.inode = state->inode,
 		.owner = { .clientid = clp->cl_clientid,
 			   .id = lsp->ls_seqid.owner_id,
-			   .s_dev = server->s_dev },
+			   .s_dev = server->super->s_dev },
 	};
 	int status;
 
@@ -7689,7 +7689,7 @@ nfs4_release_lockowner(struct nfs_server *server, struct nfs4_lock_state *lsp)
 	data->server = server;
 	data->args.lock_owner.clientid = server->nfs_client->cl_clientid;
 	data->args.lock_owner.id = lsp->ls_seqid.owner_id;
-	data->args.lock_owner.s_dev = server->s_dev;
+	data->args.lock_owner.s_dev = server->super->s_dev;
 
 	msg.rpc_argp = &data->args;
 	msg.rpc_resp = &data->res;
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index d27919d7241d38..13a602c675ddb2 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -945,7 +945,7 @@ TRACE_EVENT(nfs4_delegreturn_exit,
 		),
 
 		TP_fast_assign(
-			__entry->dev = res->server->s_dev;
+			__entry->dev = res->server->super->s_dev;
 			__entry->fhandle = nfs_fhandle_hash(args->fhandle);
 			__entry->error = error < 0 ? -error : 0;
 			__entry->stateid_seq =
@@ -1269,7 +1269,7 @@ DECLARE_EVENT_CLASS(nfs4_getattr_event,
 		),
 
 		TP_fast_assign(
-			__entry->dev = server->s_dev;
+			__entry->dev = server->super->s_dev;
 			__entry->valid = fattr->valid;
 			__entry->fhandle = nfs_fhandle_hash(fhandle);
 			__entry->fileid = (fattr->valid & NFS_ATTR_FATTR_FILEID) ? fattr->fileid : 0;
@@ -1966,7 +1966,7 @@ DECLARE_EVENT_CLASS(nfs4_deviceid_status,
 		),
 
 		TP_fast_assign(
-			__entry->dev = server->s_dev;
+			__entry->dev = server->super->s_dev;
 			__entry->status = status;
 			__assign_str(dstaddr, server->nfs_client->cl_hostname);
 			memcpy(__entry->deviceid, deviceid->data,
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index deec76cf5afeaf..9767c5e2ed1a9a 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1420,7 +1420,7 @@ static inline void encode_openhdr(struct xdr_stream *xdr, const struct nfs_opena
 	p = xdr_encode_hyper(p, arg->clientid);
 	*p++ = cpu_to_be32(24);
 	p = xdr_encode_opaque_fixed(p, "open id:", 8);
-	*p++ = cpu_to_be32(arg->server->s_dev);
+	*p++ = cpu_to_be32(arg->server->super->s_dev);
 	*p++ = cpu_to_be32(arg->id.uniquifier);
 	xdr_encode_hyper(p, arg->id.create_time);
 }
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 29d6a55b9d400d..561221a87b02a6 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1130,13 +1130,9 @@ static int nfs_compare_mount_options(const struct super_block *s, const struct n
 static int nfs_set_super(struct super_block *s, struct fs_context *fc)
 {
 	struct nfs_server *server = fc->s_fs_info;
-	int ret;
 
 	s->s_d_op = server->nfs_client->rpc_ops->dentry_ops;
-	ret = set_anon_super(s, server);
-	if (ret == 0)
-		server->s_dev = s->s_dev;
-	return ret;
+	return set_anon_super(s, server);
 }
 
 static int nfs_compare_super_address(struct nfs_server *server1,
@@ -1292,8 +1288,8 @@ int nfs_get_tree_common(struct fs_context *fc)
 		nfs_free_server(server);
 		server = NULL;
 	} else {
-		error = super_setup_bdi_name(s, "%u:%u", MAJOR(server->s_dev),
-					     MINOR(server->s_dev));
+		error = super_setup_bdi_name(s, "%u:%u", MAJOR(s->s_dev),
+					     MINOR(s->s_dev));
 		if (error)
 			goto error_splat_super;
 		s->s_bdi->io_pages = server->rpages;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 20eeba8b009df1..9c71af0e3516fa 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -190,7 +190,6 @@ struct nfs_server {
 	struct timespec64	time_delta;	/* smallest time granularity */
 	unsigned long		mount_time;	/* when this fs was mounted */
 	struct super_block	*super;		/* VFS super block */
-	dev_t			s_dev;		/* superblock dev numbers */
 	struct nfs_auth_info	auth_info;	/* parsed auth flavors */
 
 #ifdef CONFIG_NFS_FSCACHE
-- 
2.39.2

