Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655445E80BA
	for <lists+cgroups@lfdr.de>; Fri, 23 Sep 2022 19:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiIWRcD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 13:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIWRcC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 13:32:02 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAC512BD98;
        Fri, 23 Sep 2022 10:32:01 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d82so773301pfd.10;
        Fri, 23 Sep 2022 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date;
        bh=1j5Ql9rL37iPMOSlhnWDpxhkWzpqM9TX0V/l3pD1H2A=;
        b=igB1iPgGCLD9KZEhspvQpefRM95eLmbd+I+sv8MaBi0Qbu/C6e7757NtMD2t9UliqK
         fjuGtfGRfw5/7i0+/vTbW/fF/gaX61Fkyw5IW8VxEzzSBMx8rmRr85zlUUuxDwKWHEb5
         4hjxNbzZpQiX5xNrGkS+2vjHUkQSrweCDOTCIHEjw1Dbx81roj0glg251TxbPb/cur+B
         BmGCFScBEbv+3e0KEwgb9LnKiZmaEe/2S7EyMl5UP5P4/oVOLdKDa2+QedQtOxc3877j
         C8gA8VcoHOk4i6APPIREhKmky+C+FL9ELvrR0xej0a2ewf2pSesszorvo9VctdIqoV1b
         03kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1j5Ql9rL37iPMOSlhnWDpxhkWzpqM9TX0V/l3pD1H2A=;
        b=l7rA9qDkFNpdTBI1oHbxLlKjZa1bWrRDkj5gjQrn+nTJxZKqNbwlnPqgRmZT6cNz7r
         TKNT/Jrjbn8OdDte8tQCVtiH0u/oCkTziNlIensFMB2BDUL6LWSRnOuGr+DZwO6LIPhX
         Ep57bfNhelgimLbmXOwAOX1s7cFtjS9960Ap9IVMXcdAQKtnbRcClBv2i4xRVne5v5JY
         hBA5j4JM+7A3fMWgAZdTHKX70KAu5git0+wZ8m/ga5zkbIcXk/1oYfEqh5dDwdI2Ss8M
         OWhj2P4Qic4IgYFIx4I7Wt48N9qz22w26O5B4Sfh9jaggrdNrA07uuogd80esGe7ppTN
         Rg5A==
X-Gm-Message-State: ACrzQf2nM1ZpV28W4kIi27axxOmvPlCf1b4U09DtRoFfiYjZYcKXVfHl
        Ihr3Dkd7Ah1O8WQPaPmYb40=
X-Google-Smtp-Source: AMsMyM60Ab0fb1L+ScmUWYXqEejLlVPeZ/xIe/7oZuz8JFqLbriHix14/YAmf7sXiNZb3xqi9ire5w==
X-Received: by 2002:a63:2212:0:b0:43b:f03d:856a with SMTP id i18-20020a632212000000b0043bf03d856amr8627306pgi.192.1663954320854;
        Fri, 23 Sep 2022 10:32:00 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y14-20020a62ce0e000000b0053e66f57334sm6702256pfg.112.2022.09.23.10.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 10:32:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 23 Sep 2022 07:31:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Marco Patalano <mpatalan@redhat.com>,
        Muneendra <muneendra.kumar@broadcom.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: [PATCH cgroup/for-6.1] cgroup: Make cgroup_get_from_id() prettier
Message-ID: <Yy3tjvIGd2j4wnSw@slm.duckdns.org>
References: <20220923115119.2035603-1-ming.lei@redhat.com>
 <Yy3tEKSV+vg6swOd@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yy3tEKSV+vg6swOd@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From 7e1eb5437d3c3fdb61d45378579aab383cafc694 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 23 Sep 2022 07:23:06 -1000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After merging 836ac87d ("cgroup: fix cgroup_get_from_id") into for-6.1, its
combination with two commits in for-6.1 - 4534dee9 ("cgroup: cgroup: Honor
caller's cgroup NS when resolving cgroup id") and fa7e439c ("cgroup:
Homogenize cgroup_get_from_id() return value") - makes the gotos in the
error handling path too ugly while not adding anything of value.

All that the gotos are saving is one extra kernfs_put() call. Let's remove
the gotos and perform error returns directly.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Michal Koutný <mkoutny@suse.com>
---
Hello,

Ming, Michal, you guys' changes to cgroup_get_from_id() combine to make
cgroup_get_from_id() a bit too ugly, so I applied the following patch to
cgroup/for-6.1. Please take a look and lemme know if I broke anything.

Thanks.

 kernel/cgroup/cgroup.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 0d93cd17548c..c1f1ef6090da 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6066,14 +6066,16 @@ void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 struct cgroup *cgroup_get_from_id(u64 id)
 {
 	struct kernfs_node *kn;
-	struct cgroup *cgrp = NULL, *root_cgrp;
+	struct cgroup *cgrp, *root_cgrp;
 
 	kn = kernfs_find_and_get_node_by_id(cgrp_dfl_root.kf_root, id);
 	if (!kn)
-		goto out;
+		return ERR_PTR(-ENOENT);
 
-	if (kernfs_type(kn) != KERNFS_DIR)
-		goto put;
+	if (kernfs_type(kn) != KERNFS_DIR) {
+		kernfs_put(kn);
+		return ERR_PTR(-ENOENT);
+	}
 
 	rcu_read_lock();
 
@@ -6082,21 +6084,20 @@ struct cgroup *cgroup_get_from_id(u64 id)
 		cgrp = NULL;
 
 	rcu_read_unlock();
-put:
 	kernfs_put(kn);
 
 	if (!cgrp)
-		goto out;
+		return ERR_PTR(-ENOENT);
 
 	spin_lock_irq(&css_set_lock);
 	root_cgrp = current_cgns_cgroup_from_root(&cgrp_dfl_root);
 	spin_unlock_irq(&css_set_lock);
 	if (!cgroup_is_descendant(cgrp, root_cgrp)) {
 		cgroup_put(cgrp);
-		cgrp = NULL;
+		return ERR_PTR(-ENOENT);
 	}
-out:
-	return cgrp ?: ERR_PTR(-ENOENT);
+
+	return cgrp;
 }
 EXPORT_SYMBOL_GPL(cgroup_get_from_id);
 
-- 
2.37.3

