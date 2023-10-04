Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96887B83F7
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 17:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243195AbjJDPpR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Oct 2023 11:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjJDPpQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Oct 2023 11:45:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF1ABF;
        Wed,  4 Oct 2023 08:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696434312; x=1727970312;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=R3WnGCcHkT1lyLmM5v4NwuNwkg5B7PuvL34RS8utXYc=;
  b=ffFJ1VyY30iJgxlT6itISvEMkhgihPIM4wW2ZOXqMmTc5wjdCA/gRERP
   YkjiZWruDmm1ZkCynPE99SjaY1MkJu2rLc5QqbRqRv/X/NCT94IweMPXU
   a5JwwC4n/6m3wYh20WjMK9L9rqKK/3n+znhJbtXaMkYIyvO9P71RRjZdM
   8NgfOtHqx6zXy6rcXxRoskN/TOGLcJ0YrzouFcAK8qdttKAAU+MqWSCs1
   IulwbNig9y0TtlKyFaUgB9EbojSGv4OorIyRXiNfwsP5KP/B+qgPQRjv8
   Gji+TDwXfzq2r5QghyYHSRA4dAJydIVNljOcGn2y/KlDUpHLDQzEc4sP8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="382068935"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="382068935"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 08:45:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="745027765"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="745027765"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.96.100])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 04 Oct 2023 08:45:09 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Jarkko Sakkinen" <jarkko@kernel.org>, dave.hansen@linux.intel.com,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sohil.mehta@intel.com
Cc:     zhiquan1.li@intel.com, kristen@linux.intel.com, seanjc@google.com,
        zhanb@microsoft.com, anakrish@microsoft.com,
        mikko.ylinen@linux.intel.com, yangjie@microsoft.com
Subject: Re: [PATCH v5 01/18] cgroup/misc: Add per resource callbacks for CSS
 events
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-2-haitao.huang@linux.intel.com>
 <CVS5XFKKTTUZ.XRMYK1ADHSPG@suppilovahvero>
 <op.2buytfetwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <CVSVH3ARQBRC.1QUTEQE3YNN5T@qgv27q77ld-mac>
 <CVSVJ8DYAME8.SMTH7VYG7ER@qgv27q77ld-mac>
 <op.2bwqct0rwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <CVYBI76N4PTF.38BQ9KIBIOGEH@seitikki> <CVYBO2F1D1NC.1N7LNWPTDRG04@seitikki>
Date:   Wed, 04 Oct 2023 10:45:08 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.2cardibgwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <CVYBO2F1D1NC.1N7LNWPTDRG04@seitikki>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jarkko

On Mon, 02 Oct 2023 17:55:14 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:
...
>> > >> I noticed this one later:
>> > >>
>> > >> It would better to create a separate ops struct and declare the  
>> instance
>> > >> as const at minimum.
>> > >>
>> > >> Then there is no need for dynamic assigment of ops and all that is  
>> in
>> > >> rodata. This is improves both security and also allows static  
>> analysis
>> > >> bit better.
>> > >>
>> > >> Now you have to dynamically trace the struct instance, e.g. in  
>> case of
>> > >> a bug. If this one done, it would be already in the vmlinux.
>> > >I.e. then in the driver you can have static const struct declaration
>> > > with *all* pointers pre-assigned.
>> > >
>> > > Not sure if cgroups follows this or not but it is *objectively*
>> > > better. Previous work is not always best possible work...
>> > >
>> >
>> > IIUC, like vm_ops field in vma structs. Although function pointers in
>> > vm_ops are assigned statically, but you still need dynamically assign
>> > vm_ops for each instance of vma.
>> >
>> > So the code will look like this:
>> >
>> > if (parent_cg->res[i].misc_ops && parent_cg->res[i].misc_ops->alloc)
>> > {
>> > ...
>> > }
>> >
>> > I don't see this is the pattern used in cgroups and no strong opinion
>> > either way.
>> >
>> > TJ, do you have preference on this?
>>
>> I do have strong opinion on this. In the client side we want as much
>> things declared statically as we can because it gives more tools for
>> statical analysis.
>>
>> I don't want to see dynamic assignments in the SGX driver, when they
>> are not actually needed, no matter things are done in cgroups.
>
> I.e. I don't really even care what crazy things cgroups subsystem
> might do or not do. It's not my problem.
>
> All I care is that we *do not* have any use for assigning those
> pointers at run-time. So do whatever you want with cgroups side
> as long as this is not the case.
>


So I will update to something like following. Let me know if that's  
correct understanding.
@tj, I'd appreciate for your input on whether this is acceptable from  
cgroups side.

--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -31,22 +31,26 @@ struct misc_cg;

  #include <linux/cgroup.h>

+/* per resource callback ops */
+struct misc_operations_struct {
+       int (*alloc)(struct misc_cg *cg);
+       void (*free)(struct misc_cg *cg);
+       void (*max_write)(struct misc_cg *cg);
+};
  /**
   * struct misc_res: Per cgroup per misc type resource
   * @max: Maximum limit on the resource.
   * @usage: Current usage of the resource.
   * @events: Number of times, the resource limit exceeded.
+ * @priv: resource specific data.
+ * @misc_ops: resource specific operations.
   */
  struct misc_res {
         u64 max;
         atomic64_t usage;
         atomic64_t events;
         void *priv;
-
-       /* per resource callback ops */
-       int (*alloc)(struct misc_cg *cg);
-       void (*free)(struct misc_cg *cg);
-       void (*max_write)(struct misc_cg *cg);
+       const struct misc_operations_struct *misc_ops;
  };

...
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index 4633b8629e63..500415087643 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -277,8 +277,8 @@ static ssize_t misc_cg_max_write(struct  
kernfs_open_file *of, char *buf,

         if (READ_ONCE(misc_res_capacity[type])) {
                 WRITE_ONCE(cg->res[type].max, max);
-               if (cg->res[type].max_write)
-                       cg->res[type].max_write(cg);
+               if (cg->res[type].misc_ops &&  
cg->res[type].misc_ops->max_write)
+                       cg->res[type].misc_ops->max_write(cg);

[skip other similar changes in misc.c]

And on SGX side, it'll be updated like this:

--- a/arch/x86/kernel/cpu/sgx/epc_cgroup.c
+++ b/arch/x86/kernel/cpu/sgx/epc_cgroup.c
@@ -376,6 +376,14 @@ static void sgx_epc_cgroup_max_write(struct misc_cg  
*cg)
         queue_work(sgx_epc_cg_wq, &rc.epc_cg->reclaim_work);
  }

+static int sgx_epc_cgroup_alloc(struct misc_cg *cg);
+
+const struct misc_operations_struct sgx_epc_cgroup_ops = {
+        .alloc = sgx_epc_cgroup_alloc,
+        .free = sgx_epc_cgroup_free,
+        .max_write = sgx_epc_cgroup_max_write,
+};
+
  static int sgx_epc_cgroup_alloc(struct misc_cg *cg)
  {
         struct sgx_epc_cgroup *epc_cg;
@@ -386,12 +394,7 @@ static int sgx_epc_cgroup_alloc(struct misc_cg *cg)

         sgx_lru_init(&epc_cg->lru);
         INIT_WORK(&epc_cg->reclaim_work, sgx_epc_cgroup_reclaim_work_func);
-       cg->res[MISC_CG_RES_SGX_EPC].alloc = sgx_epc_cgroup_alloc;
-       cg->res[MISC_CG_RES_SGX_EPC].free = sgx_epc_cgroup_free;
-       cg->res[MISC_CG_RES_SGX_EPC].max_write = sgx_epc_cgroup_max_write;
-       cg->res[MISC_CG_RES_SGX_EPC].priv = epc_cg;
-       epc_cg->cg = cg;
-
+       cg->res[MISC_CG_RES_SGX_EPC].misc_ops = &sgx_epc_cgroup_ops;
         return 0;
  }


Thanks again to all of you for feedback.

Haitao
