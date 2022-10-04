Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5827D5F4C3E
	for <lists+cgroups@lfdr.de>; Wed,  5 Oct 2022 00:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJDWzG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Oct 2022 18:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJDWzF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Oct 2022 18:55:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD80DF95
        for <cgroups@vger.kernel.org>; Tue,  4 Oct 2022 15:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664924100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DC7n5vrJm9+7rtzmCox+oVCN8flf2wk8nlQItN2YxhA=;
        b=W72N73GBVXuNma9FdfBikf9sd4fupF03OjMiVi6ldd4VlkkjCmlVIWvPDtbmcAls/AqL7R
        Lu5YEYC187FvMV2xrPretJbgVuvmgyGV3io4XKOWO1lfM8yEjd7JccxlI1CTOXD6WgDMoZ
        dvu3TF5yMSQlYhcKYa2UdBeXw6XLwjo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-0IBI0tUgMT6xquT_Hvi9Dg-1; Tue, 04 Oct 2022 18:53:38 -0400
X-MC-Unique: 0IBI0tUgMT6xquT_Hvi9Dg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 644173800C22;
        Tue,  4 Oct 2022 22:53:38 +0000 (UTC)
Received: from [10.22.10.217] (unknown [10.22.10.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D34C235429;
        Tue,  4 Oct 2022 22:53:37 +0000 (UTC)
Message-ID: <35942f9a-e21c-9317-3d9f-61cbac5f8dfd@redhat.com>
Date:   Tue, 4 Oct 2022 18:53:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v8 3/3] blk-cgroup: Optimize blkcg_rstat_flush()
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20221004151748.293388-1-longman@redhat.com>
 <20221004151748.293388-4-longman@redhat.com> <YzyAT/lfyKhOnOpy@blackbook>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YzyAT/lfyKhOnOpy@blackbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/4/22 14:49, Michal Koutný wrote:
> Hello.
>
> On Tue, Oct 04, 2022 at 11:17:48AM -0400, Waiman Long <longman@redhat.com> wrote:
>> To protect against destruction of blkg, a percpu reference is gotten
>> when putting into the lockless list and put back when removed.
> Just to conclude my previous remark about the loop, let me try
> explaining it more precisely:
>
> blkcg->lhead via blkg_iostat_set holds reference to blkcg_gq
>     (taken in in blk_cgroup_bio_start)
>
> blkcg_gq holds reference to its blkcg_gq->blkcg
>     (taken in blkg_create)
>
> The cycle has two edges, the latter is broken in __blkg_release but
> that's a release callback of the involved blkcg_gq->refcnt, so it won't
> be called.
>
> The first edges is broken in blkcg_rstat_flush and that's more promising.
> The current code does the final flushes -- in css_release_work_fn.
> The problem is that it's the release callback of blkcg->css, i.e. it's
> also referenced on the cycle, therefore this final flush won't happen
> before cycle is broken.
>
> Fortunately, any other caller of cgroup_rstat_flush comes to the rescue
> -- the blkcg_rstat_flush on the stuck blkcg would decompose lhead list
> and the reference cycle is broken.
>
> In summary, I think this adds the reference cycle but its survival time
> is limited to the soonest cgroup_rstat_flush call, which should not
> cause practical troubles.

Thanks for the explanation. I now get what you are referring to. Yes, 
this delayed blkcg removal problem is annoying. I think the following 
patch should eliminate this issue. What do you think?

Cheers,
Longman

----------------8<-------------[ cut here ]------------------

  block/blk-cgroup.c     | 15 ++++++++++++++-
  include/linux/cgroup.h |  1 +
  kernel/cgroup/rstat.c  | 20 ++++++++++++++++++++
  3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 63569b05db0d..f896caef9947 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1122,10 +1122,12 @@ struct list_head *blkcg_get_cgwb_list(struct 
cgroup_subsys_state *css)
   */
  static void blkcg_destroy_blkgs(struct blkcg *blkcg)
  {
+    int cpu;
+
      might_sleep();

+    css_get(&blkcg->css);
      spin_lock_irq(&blkcg->lock);
-
      while (!hlist_empty(&blkcg->blkg_list)) {
          struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,
                          struct blkcg_gq, blkcg_node);
@@ -1148,6 +1150,17 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
      }

      spin_unlock_irq(&blkcg->lock);
+
+    /*
+     * Flush all the non-empty percpu lockless lists.
+     */
+    for_each_possible_cpu(cpu) {
+        struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
+
+        if (!llist_empty(lhead))
+            cgroup_rstat_css_flush(&blkcg->css, cpu);
+    }
+    css_put(&blkcg->css);
  }

  /**
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index ac5d0515680e..33e226a34073 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -763,6 +763,7 @@ void cgroup_rstat_flush(struct cgroup *cgrp);
  void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp);
  void cgroup_rstat_flush_hold(struct cgroup *cgrp);
  void cgroup_rstat_flush_release(void);
+void cgroup_rstat_css_flush(struct cgroup_subsys_state *css, int cpu);

  /*
   * Basic resource stats.
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index feb59380c896..a4e18d627b54 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -251,6 +251,26 @@ void cgroup_rstat_flush_release(void)
      spin_unlock_irq(&cgroup_rstat_lock);
  }

+/**
+ * cgroup_rstat_css_flush - flush stats for the given css and cpu
+ * @css: target css to be flush
+ * @cpu: the cpu that holds the stats to be flush
+ *
+ * A lightweight rstat flush operation for a given css and cpu.
+ * Only the cpu_lock is being held for mutual exclusion, the 
cgroup_rstat_lock
+ * isn't used.
+ */
+void cgroup_rstat_css_flush(struct cgroup_subsys_state *css, int cpu)
+{
+    raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
+
+    raw_spin_lock_irq(cpu_lock);
+    rcu_read_lock();
+    css->ss->css_rstat_flush(css, cpu);
+    rcu_read_unlock();
+    raw_spin_unlock_irq(cpu_lock);
+}
+
  int cgroup_rstat_init(struct cgroup *cgrp)
  {
      int cpu;
-- 


