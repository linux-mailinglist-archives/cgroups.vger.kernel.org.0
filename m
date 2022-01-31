Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CB14A4052
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 11:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240040AbiAaKfw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 05:35:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:54756 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239989AbiAaKfw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 31 Jan 2022 05:35:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643625352; x=1675161352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YWtKq8OcN++bgZXQOD7vrGgwPikzV7AzgE9vpzi2/ms=;
  b=aGJGWLkuz93qzF0+O4SpjoeqDtCRqmNGt2OylFOJ5Jg2mFBt66wpXvp1
   uR+Q+YKK614Pm+W27Y4rnJn2tvX/lVRWt3KxTyUC6dfvhVcCeTdGWsId5
   u3b102124K1ij9JBNMpffk/KZJhDAA+bTRmYdxiuxBi6h93hpsajE0al5
   yZLc9/AWZ4vI5yAJblynCfDPQKpMb0GxgYFAnGBbij2GMEpbRrSq9NrEg
   WVS198gDDp1qe+1A5PEAXG9RwP4IRzFCnaU6y5kLhYq9hhRzrq6hBbJ31
   aJHWDPEQBWhu1WwfaLqXvy6rvOXCvsv/XgDz9OOR3NgI+vOsUKQDCH/oP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="310746496"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="310746496"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 02:35:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="582605815"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 02:35:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nEU1E-00GpVR-3q;
        Mon, 31 Jan 2022 12:34:44 +0200
Date:   Mon, 31 Jan 2022 12:34:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2 1/3] lib/vsprintf: Avoid redundant work with 0 size
Message-ID: <Yfe7Q5cx+MoaOev/@smile.fi.intel.com>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-2-longman@redhat.com>
 <d99b3c4b-7b6e-529-6e4b-b91b65c92d81@google.com>
 <Yfe5Bb3U6Uil7Y6g@smile.fi.intel.com>
 <Yfe6SfG4CqzWSaMM@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfe6SfG4CqzWSaMM@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 31, 2022 at 12:30:33PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 31, 2022 at 12:25:09PM +0200, Andy Shevchenko wrote:
> > On Sun, Jan 30, 2022 at 12:49:37PM -0800, David Rientjes wrote:
> > > On Sat, 29 Jan 2022, Waiman Long wrote:
> > > 
> > > > For *scnprintf(), vsnprintf() is always called even if the input size is
> > > > 0. That is a waste of time, so just return 0 in this case.
> > 
> > Why do you think it's not legit?
> 
> I have to elaborate.
> 
> For *nprintf() the size=0 is quite useful to have.
> For *cnprintf() the size=0 makes less sense, but, if we read `man snprintf()`:
> 
>   The  functions  snprintf() and vsnprintf() do not write more than size bytes
>   (including the terminating null byte ('\0')). If the output was truncated due
>   to this limit, then the return value is the  number of  characters (excluding
>   the terminating null byte) which would have been written to the final string
>   if enough space had been available. Thus, a return value of size or more
>   means  that  the  output  was truncated.  (See also below under NOTES.)
> 
>   If an output error is encountered, a negative value is returned.
> 
> Note the last sentence there. You need to answer to it in the commit message
> why your change is okay and it will show that you thought through all possible
> scenarios.

Also it seems currently the kernel documentation is not aligned with the code

  "If @size is == 0 the function returns 0."

It should mention the (theoretical?) possibility of getting negative value,
if vsnprintf() returns negative value.

-- 
With Best Regards,
Andy Shevchenko


