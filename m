Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 977F2176A21
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2020 02:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCCBmI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Mar 2020 20:42:08 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52957 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726773AbgCCBmI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Mar 2020 20:42:08 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D4FDC221BD;
        Mon,  2 Mar 2020 20:42:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 02 Mar 2020 20:42:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=766BVSSbl7doT
        GCCsHkHXBjD7nP/xv3/vCxGfSjHZZI=; b=jogTPfXeyy0V2sHXCDtLtmKBXhTOu
        XyVG7LOM0T7QlRtUSxQxkGU9uY1BZUiWuJUEgWBgV/k3VVP8MuLksgl1CjXlfzwp
        izOEbvIjGF8M7MBfb1rtd3Xf1d4/GwpsF8QRtYcCXPRRuCQrRVhzCmDN925SlP5J
        HExE8PAR1g30+ylk1mCr5KK51z4x+GFMEhPHuziLGmjl1KQ67Wm7fNCrAUENpsQV
        AuKonxFF4GykGwvaOr0qNcVv+zn7ecMoELpAKRySOqvDh19pPD6NQQ6w+4X9AHgS
        dgCISFtcyA0gqsDLYp9C2j+ZnVjHK/ABO00Xa8S5NqrRMjfzw6Ah2pE8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=766BVSSbl7doTGCCsHkHXBjD7nP/xv3/vCxGfSjHZZI=; b=FiuHX7mg
        UqSRrDeIGyF5AuVuGBALtFgWxT2tgVws3KxIoj1Xt69Hq+NUVad4anTDwXA/Y3no
        L7uPMcfMNsTkOPuFsUz0rITRv7P5Hkb+jp3vSe4TI1g+8Ec4HHrsCrsocjKbUdPy
        kdQ6kWJPtb8kZa+uM2OWpur0KgBzkug4J3pmHqsEDcwfHeIZ7xtj1dhnf3fN7WU7
        EiHh0YKXimkZS24SuZV3sKG4RbnL+Wre09EYJ/25sZpGvSOEkDBfTAz5uNfaasCP
        Y/OcPfGMmPAxpvyXCwd40OPWwZr9l+etLUqOuja3zhLxGGarEwpmU3B1lhpew3O6
        bOEqW/u1F4Q0Gw==
X-ME-Sender: <xms:7rVdXrTrvybhPmLGsFjEfGzs3fKNC7DPAGeL7mkHrMcNNuW-CidCJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddthedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucfkphepudeifedruddugedrudefvddruddvkeenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegu
    gihuuhhurdighiii
X-ME-Proxy: <xmx:7rVdXjSz2LQCABDXZantLmAp8dpj-Sw7YvJIy4j_KD8nDkr0VF6uLA>
    <xmx:7rVdXu0PH5aacjzLMcXimOS4nJ05hp4SRm018g_3Sjh1L4ZbH3YYXw>
    <xmx:7rVdXtwBrxV4BXiGAXfi0Tr-S5bn48ZNmdUFlQrcnbTvJx_PMkP5Fw>
    <xmx:7rVdXp_KU_5eUaFj5qfYakZF2-n0rBQPUnX4VDrh_PVccaBwmK9-KA>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.128])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6CDCF3060FD3;
        Mon,  2 Mar 2020 20:42:05 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     cgroups@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel-team@fb.com
Subject: [PATCH 1/2] kernfs: Add option to enable user xattrs
Date:   Mon,  2 Mar 2020 17:39:00 -0800
Message-Id: <20200303013901.32150-2-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200303013901.32150-1-dxu@dxuuu.xyz>
References: <20200303013901.32150-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

User extended attributes are useful as metadata storage for kernfs
consumers like cgroups. Especially in the case of cgroups, it is useful
to have a central metadata store that multiple processes/services can
use to coordinate actions.

A concrete example is for userspace out of memory killers. We want to
let delegated cgroup subtree owners (running as non-root) to be able to
say "please avoid killing this cgroup". In server environments this is
less important as everyone is running as root. But for desktop linux,
this is more important.

This patch introduces a new flag, KERNFS_ROOT_SUPPORT_USER_XATTR, that
lets kernfs consumers enable user xattr support. An initial limit of 128
entries is placed because xattrs come from kernel memory and we don't
want to let unprivileged users accidentally eat up too much kernel
memory.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 fs/kernfs/inode.c           | 47 +++++++++++++++++++++++++++++++++++++
 fs/kernfs/kernfs-internal.h |  1 +
 include/linux/kernfs.h      |  6 +++++
 3 files changed, 54 insertions(+)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index d0f7a5abd9a9..6d603d1177c4 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -53,6 +53,7 @@ static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, int alloc)
 	kn->iattr->ia_ctime = kn->iattr->ia_atime;
 
 	simple_xattrs_init(&kn->iattr->xattrs);
+	atomic_set(&kn->iattr->nr_user_xattrs, 0);
 out_unlock:
 	ret = kn->iattr;
 	mutex_unlock(&iattr_mutex);
@@ -327,6 +328,45 @@ static int kernfs_vfs_xattr_set(const struct xattr_handler *handler,
 	return kernfs_xattr_set(kn, name, value, size, flags);
 }
 
+static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
+				     struct dentry *unused, struct inode *inode,
+				     const char *suffix, const void *value,
+				     size_t size, int flags)
+{
+	struct kernfs_node *kn = inode->i_private;
+	atomic_t *nr = &kn->iattr->nr_user_xattrs;
+	int ret;
+
+	if (!(kernfs_root(kn)->flags & KERNFS_ROOT_SUPPORT_USER_XATTR)) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (value && atomic_inc_return(nr) > KERNFS_MAX_USER_XATTRS) {
+		ret = -ENOSPC;
+		goto dec_out;
+	}
+
+	ret = kernfs_vfs_xattr_set(handler, unused, inode, suffix, value,
+				   size, flags);
+
+	/*
+	 * Don't decrement counter if we successfully added an xattr
+	 */
+	if (value && !ret)
+		goto out;
+
+dec_out:
+	/*
+	 * Removing a nonexistent xattr without XATTR_REPLACE returns success
+	 * so we have to make sure here we don't go negative.
+	 */
+	if (atomic_dec_return(nr) < 0)
+		atomic_inc(nr);
+out:
+	return ret;
+}
+
 static const struct xattr_handler kernfs_trusted_xattr_handler = {
 	.prefix = XATTR_TRUSTED_PREFIX,
 	.get = kernfs_vfs_xattr_get,
@@ -339,8 +379,15 @@ static const struct xattr_handler kernfs_security_xattr_handler = {
 	.set = kernfs_vfs_xattr_set,
 };
 
+static const struct xattr_handler kernfs_user_xattr_handler = {
+	.prefix = XATTR_USER_PREFIX,
+	.get = kernfs_vfs_xattr_get,
+	.set = kernfs_vfs_user_xattr_set,
+};
+
 const struct xattr_handler *kernfs_xattr_handlers[] = {
 	&kernfs_trusted_xattr_handler,
 	&kernfs_security_xattr_handler,
+	&kernfs_user_xattr_handler,
 	NULL
 };
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 2f3c51d55261..745505ce1f37 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -26,6 +26,7 @@ struct kernfs_iattrs {
 	struct timespec64	ia_ctime;
 
 	struct simple_xattrs	xattrs;
+	atomic_t		nr_user_xattrs;
 };
 
 /* +1 to avoid triggering overflow warning when negating it */
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index dded2e5a9f42..0e06d67db05f 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -39,6 +39,7 @@ enum kernfs_node_type {
 
 #define KERNFS_TYPE_MASK	0x000f
 #define KERNFS_FLAG_MASK	~KERNFS_TYPE_MASK
+#define KERNFS_MAX_USER_XATTRS  128
 
 enum kernfs_node_flag {
 	KERNFS_ACTIVATED	= 0x0010,
@@ -78,6 +79,11 @@ enum kernfs_root_flag {
 	 * fhandle to access nodes of the fs.
 	 */
 	KERNFS_ROOT_SUPPORT_EXPORTOP		= 0x0004,
+
+	/*
+	 * Support user xattrs to be written to nodes rooted at this root.
+	 */
+	KERNFS_ROOT_SUPPORT_USER_XATTR		= 0x0008,
 };
 
 /* type-specific structures for kernfs_node union members */
-- 
2.21.1

