Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E21C51E03B
	for <lists+cgroups@lfdr.de>; Fri,  6 May 2022 22:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443339AbiEFUmQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 May 2022 16:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443211AbiEFUmK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 May 2022 16:42:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9112D1F1;
        Fri,  6 May 2022 13:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651869503; x=1683405503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2b+dWfxndlwKVu8r56BjaXCpV9WofllYiBZQXaA0tCY=;
  b=FdtiNxtxPPI7oayfk7MZSOfzKi6uV/5pJlzpqtJksnsObAAS3DMnn4Qo
   VTzIZ9V7E2v+gIbJ5H/ke4mjrwWJtXfnANFJAf7hUU+SHvyWkGgeqNp7H
   IH9p/5Byw64Fan43xSC9JlSyQkVzHdf93C5gIJxSwXl2NxSoI2/2jJNjX
   ahTJMD2s672iPNpeUlUKPGFlwwv286z5Xu7wZZqxG0z9hzZut1153gkUw
   CFQpAwWqGRv3YPTVHo8FyyyYBAtt4VkMvFu5hlrz+bOMDtnS5lKkI/ASk
   lEtTnCMix2Jce0Ts0IlJ8jNI9SuOehqtjBg5tFN/mLKJqyadNGl56CIVU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="248474801"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="248474801"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 13:38:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="564011788"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 May 2022 13:38:18 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn4iQ-000DsG-38;
        Fri, 06 May 2022 20:38:18 +0000
Date:   Sat, 7 May 2022 04:38:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vasily Averin <vvs@openvz.org>, Shakeel Butt <shakeelb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     kbuild-all@lists.01.org, kernel@openvz.org,
        linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH] percpu: improve percpu_alloc_percpu event trace
Message-ID: <202205070420.aAhuqpYk-lkp@intel.com>
References: <8d627f02-183f-c4e7-7c15-77b2b438536b@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d627f02-183f-c4e7-7c15-77b2b438536b@openvz.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Vasily,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rostedt-trace/for-next]
[also build test WARNING on hnaz-mm/master v5.18-rc5]
[cannot apply to dennis-percpu/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Vasily-Averin/percpu-improve-percpu_alloc_percpu-event-trace/20220506-124742
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220507/202205070420.aAhuqpYk-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/dee6876db0a7a4715516e673f9edaca2ba40677c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vasily-Averin/percpu-improve-percpu_alloc_percpu-event-trace/20220506-124742
        git checkout dee6876db0a7a4715516e673f9edaca2ba40677c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   mm/percpu.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/percpu.h):
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast from restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long flags @@     got restricted gfp_t [usertype] gfp_flags @@
   include/trace/events/percpu.h:11:1: sparse:     expected unsigned long flags
   include/trace/events/percpu.h:11:1: sparse:     got restricted gfp_t [usertype] gfp_flags
   mm/percpu.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/percpu.h):
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast to restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: cast to restricted gfp_t
>> include/trace/events/percpu.h:11:1: sparse: sparse: restricted gfp_t degrades to integer
>> include/trace/events/percpu.h:11:1: sparse: sparse: restricted gfp_t degrades to integer
   mm/percpu.c:2012:24: sparse: sparse: context imbalance in 'pcpu_balance_free' - unexpected unlock

vim +11 include/trace/events/percpu.h

df95e795a72289 Dennis Zhou   2017-06-19  10  
df95e795a72289 Dennis Zhou   2017-06-19 @11  TRACE_EVENT(percpu_alloc_percpu,
df95e795a72289 Dennis Zhou   2017-06-19  12  
df95e795a72289 Dennis Zhou   2017-06-19  13  	TP_PROTO(bool reserved, bool is_atomic, size_t size,
dee6876db0a7a4 Vasily Averin 2022-05-06  14  		 size_t align, void *base_addr, int off,
dee6876db0a7a4 Vasily Averin 2022-05-06  15  		 void __percpu *ptr, size_t bytes_alloc, gfp_t gfp_flags),
df95e795a72289 Dennis Zhou   2017-06-19  16  
dee6876db0a7a4 Vasily Averin 2022-05-06  17  	TP_ARGS(reserved, is_atomic, size, align, base_addr, off, ptr,
dee6876db0a7a4 Vasily Averin 2022-05-06  18  		bytes_alloc, gfp_flags),
df95e795a72289 Dennis Zhou   2017-06-19  19  
df95e795a72289 Dennis Zhou   2017-06-19  20  	TP_STRUCT__entry(
df95e795a72289 Dennis Zhou   2017-06-19  21  		__field(	bool,			reserved	)
df95e795a72289 Dennis Zhou   2017-06-19  22  		__field(	bool,			is_atomic	)
df95e795a72289 Dennis Zhou   2017-06-19  23  		__field(	size_t,			size		)
df95e795a72289 Dennis Zhou   2017-06-19  24  		__field(	size_t,			align		)
df95e795a72289 Dennis Zhou   2017-06-19  25  		__field(	void *,			base_addr	)
df95e795a72289 Dennis Zhou   2017-06-19  26  		__field(	int,			off		)
df95e795a72289 Dennis Zhou   2017-06-19  27  		__field(	void __percpu *,	ptr		)
dee6876db0a7a4 Vasily Averin 2022-05-06  28  		__field(	size_t,			bytes_alloc	)
dee6876db0a7a4 Vasily Averin 2022-05-06  29  		__field(	gfp_t,			gfp_flags	)
df95e795a72289 Dennis Zhou   2017-06-19  30  	),
df95e795a72289 Dennis Zhou   2017-06-19  31  	TP_fast_assign(
df95e795a72289 Dennis Zhou   2017-06-19  32  		__entry->reserved	= reserved;
df95e795a72289 Dennis Zhou   2017-06-19  33  		__entry->is_atomic	= is_atomic;
df95e795a72289 Dennis Zhou   2017-06-19  34  		__entry->size		= size;
df95e795a72289 Dennis Zhou   2017-06-19  35  		__entry->align		= align;
df95e795a72289 Dennis Zhou   2017-06-19  36  		__entry->base_addr	= base_addr;
df95e795a72289 Dennis Zhou   2017-06-19  37  		__entry->off		= off;
df95e795a72289 Dennis Zhou   2017-06-19  38  		__entry->ptr		= ptr;
dee6876db0a7a4 Vasily Averin 2022-05-06  39  		__entry->bytes_alloc	= bytes_alloc;
dee6876db0a7a4 Vasily Averin 2022-05-06  40  		__entry->gfp_flags	= gfp_flags;
df95e795a72289 Dennis Zhou   2017-06-19  41  	),
df95e795a72289 Dennis Zhou   2017-06-19  42  
dee6876db0a7a4 Vasily Averin 2022-05-06  43  	TP_printk("reserved=%d is_atomic=%d size=%zu align=%zu base_addr=%p off=%d ptr=%p bytes_alloc=%zu gfp_flags=%s",
df95e795a72289 Dennis Zhou   2017-06-19  44  		  __entry->reserved, __entry->is_atomic,
df95e795a72289 Dennis Zhou   2017-06-19  45  		  __entry->size, __entry->align,
dee6876db0a7a4 Vasily Averin 2022-05-06  46  		  __entry->base_addr, __entry->off, __entry->ptr,
dee6876db0a7a4 Vasily Averin 2022-05-06  47  		  __entry->bytes_alloc, show_gfp_flags(__entry->gfp_flags))
df95e795a72289 Dennis Zhou   2017-06-19  48  );
df95e795a72289 Dennis Zhou   2017-06-19  49  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
