Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E134A44BF
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 12:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344238AbiAaLcS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 06:32:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:12238 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379732AbiAaLaj (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 31 Jan 2022 06:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643628639; x=1675164639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IrCfoF7eVv9DU6g4PgHgEV5cLq0Eof4NwIuHTMoZg8E=;
  b=dYUK0g8hidnaRro/VYR1kcNEvPpOtfYedQMtUIUXT/kSOxPuSixeQ+JH
   3pawBbmGx9snj+aq7xvPMJIUgy45aQaPzGOa24Fdd8dp2+v5/O9YCQlSy
   Gk1cXXXJR+703azR6a/Rco1OirRU2/hnaW/1O6qnfu5/hfWQRAzWhTDnI
   NFeN4wc/ip6Vu4qFGcAlbpaycTj18UWgwIOiIbrLSFyls/u9m8jMR7s1K
   OwUwKcBr7yRYopHzLhVMkbh5dJ1hxYJYC1OD7EA80pvsR19bWGKPuVsgc
   aOplCg+lPJ3iEf7csgzxzeFPQk6+mLaeFKhvUoCj0XbNv+uuvcwRIWTxJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="333798871"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="333798871"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 03:23:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="479042021"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 03:23:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nEUle-00GqYd-Oi;
        Mon, 31 Jan 2022 13:22:42 +0200
Date:   Mon, 31 Jan 2022 13:22:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     David Rientjes <rientjes@google.com>,
        Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2 1/3] lib/vsprintf: Avoid redundant work with 0 size
Message-ID: <YffGgozjI4W2Vamp@smile.fi.intel.com>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-2-longman@redhat.com>
 <d99b3c4b-7b6e-529-6e4b-b91b65c92d81@google.com>
 <Yfe5Bb3U6Uil7Y6g@smile.fi.intel.com>
 <Yfe6SfG4CqzWSaMM@smile.fi.intel.com>
 <Yfe7Q5cx+MoaOev/@smile.fi.intel.com>
 <d44824d4-2dd1-a8ab-d3ee-ac67b749ca6f@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d44824d4-2dd1-a8ab-d3ee-ac67b749ca6f@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 31, 2022 at 12:02:29PM +0100, Rasmus Villemoes wrote:
> On 31/01/2022 11.34, Andy Shevchenko wrote:
> > On Mon, Jan 31, 2022 at 12:30:33PM +0200, Andy Shevchenko wrote:
> >> On Mon, Jan 31, 2022 at 12:25:09PM +0200, Andy Shevchenko wrote:
> >>> On Sun, Jan 30, 2022 at 12:49:37PM -0800, David Rientjes wrote:
> >>>> On Sat, 29 Jan 2022, Waiman Long wrote:
> >>>>
> >>>>> For *scnprintf(), vsnprintf() is always called even if the input size is
> >>>>> 0. That is a waste of time, so just return 0 in this case.
> >>>
> >>> Why do you think it's not legit?
> >>
> >> I have to elaborate.
> >>
> >> For *nprintf() the size=0 is quite useful to have.
> >> For *cnprintf() the size=0 makes less sense, but, if we read `man snprintf()`:
> >>
> >>   The  functions  snprintf() and vsnprintf() do not write more than size bytes
> >>   (including the terminating null byte ('\0')). If the output was truncated due
> >>   to this limit, then the return value is the  number of  characters (excluding
> >>   the terminating null byte) which would have been written to the final string
> >>   if enough space had been available. Thus, a return value of size or more
> >>   means  that  the  output  was truncated.  (See also below under NOTES.)
> >>
> >>   If an output error is encountered, a negative value is returned.
> >>
> >> Note the last sentence there. You need to answer to it in the commit message
> >> why your change is okay and it will show that you thought through all possible
> >> scenarios.
> > 
> > Also it seems currently the kernel documentation is not aligned with the code
> > 
> >   "If @size is == 0 the function returns 0."
> > 
> > It should mention the (theoretical?) possibility of getting negative value,
> > if vsnprintf() returns negative value.
> > 
> 
> The kernel's vsnprintf _will never_ return a negative value. There is
> way too much code which relies on that. It also has to work from any
> context, so we'll never do any memory allocation or anything else that
> could possibly force us to error out, and even if we encounter some
> impossible situation, we do not return a negative value, but just stop
> the output where we are.

Yep, I see the code. My comments more or less are related to the (better)
commit message which may include what you just said.

> So yes, micro-optimizing [v]scnprintf() is completely valid, but I've
> never bothered to send the patch because the use case for scnprintf() is
> primarily the
> 
>   ret += scnprintf(buf + ret, size - ret, ...);
> 
> pattern, with ret starting out at 0 and size being some non-zero number.
> When given a non-zero size, scnprintf() is guaranteed to return
> something _strictly less_ than that value; that invariant guarantees
> that the size-ret expression never becomes 0. So if scnprintf() is
> properly used, I can't think of any situation where size will be 0,
> hence I see that patch as correct-but-mostly-pointless.

Good remark and again commit message probably should elaborate this as
well.

-- 
With Best Regards,
Andy Shevchenko


