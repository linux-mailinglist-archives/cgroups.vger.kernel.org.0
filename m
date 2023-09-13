Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B19679E604
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 13:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbjIMLMI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 07:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240247AbjIMLLp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 07:11:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9376270C;
        Wed, 13 Sep 2023 04:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Q2VwcKDbn0sssCtg/tKvOFfISdo7sbQlCa3jWeP0g5o=; b=U9maC0r9MMAGiR+QOYQXHrPmxl
        hylGpcYyRZf8wlnfYzYJRGZ+ePuUrLXyBiCBj233USe8FtvXKcesNUnc6ymEuNNxot0H1zdTdIqxD
        4nZemSt5Xe+moQ3awKBJ0JWFY7hKqY5a8qTbBzA4Chr1Z80FIM12zzh+M3AcEb9HxFS5iSZondHRZ
        WQoy1PvwkQqXEgFPHOyK0Z5obK/hYR6g0WWqUFEQshG2lS0WzKwVP/zoNBlJqjuwTFZxNoSSi1ufm
        2tnBrbQ85MVzRjetu64lwiuth4qM5dROCJK8uHKhfCxDaBwLEfj6vTmeG7EfaLoILEr/TxmwYoAQM
        bOsLTfDQ==;
Received: from [190.210.221.22] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgNmA-005i9E-0r;
        Wed, 13 Sep 2023 11:11:18 +0000
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
Subject: [PATCH 16/19] x86/resctrl: release rdtgroup_mutex and the CPU hotplug lock in rdt_shutdown_sb
Date:   Wed, 13 Sep 2023 08:10:10 -0300
Message-Id: <20230913111013.77623-17-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913111013.77623-1-hch@lst.de>
References: <20230913111013.77623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

While the resctl code is a bit confusing, I can't find anything protected
by rdtgroup_mutex or the CPU hotplug lock in generic_shutdown_super or
kernfs_free_sb.  Drop the locks at the end of rdt_shutdown_sb to avoid
holding locks over method calls and VFS code which itself already has a
rather complicated locking hierarchy.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 8db767fd80df6b..e87de519493021 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2793,11 +2793,6 @@ static void rdt_shutdown_sb(struct super_block *sb)
 	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
 	static_branch_disable_cpuslocked(&rdt_enable_key);
 	kernfs_shutdown_sb(sb);
-}
-
-static void rdt_free_sb(struct super_block *sb)
-{
-	kernfs_free_sb(sb);
 	mutex_unlock(&rdtgroup_mutex);
 	cpus_read_unlock();
 }
@@ -2807,7 +2802,7 @@ static struct file_system_type rdt_fs_type = {
 	.init_fs_context	= rdt_init_fs_context,
 	.parameters		= rdt_fs_parameters,
 	.shutdown_sb		= rdt_shutdown_sb,
-	.free_sb		= rdt_free_sb,
+	.free_sb		= kernfs_free_sb,
 };
 
 static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
-- 
2.39.2

