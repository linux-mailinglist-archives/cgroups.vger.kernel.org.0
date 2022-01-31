Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CCC4A4019
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 11:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358140AbiAaK0S (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 05:26:18 -0500
Received: from mga17.intel.com ([192.55.52.151]:38123 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358132AbiAaK0R (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 31 Jan 2022 05:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643624778; x=1675160778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rnpGhLBeO/HdBBinrNjhSH3ZdFwzc3ZAIZeFErKuU6A=;
  b=SkcJ7eA6RZTlScMiOO024trJbZNNtkF46WMRtc2T2aFFxeynxquzaHMG
   GhnJnnYlvl14f/ZDy0DtaeKE0lvPuhPRWlXvxUSqS3asEStOYSn7IqF7I
   uIN57GTBjzXVJeEqWPILmoFwjpYuN02ISa1hUgjUepUy/0ztd1JyiEoD9
   bJTa7VtP8nlsxJ9Fwby4r24R8edKGLqyUIn+3pcAE23OxEHfKTeOKq2jt
   2pwzLcWHD7EmiwPWG2PO9LtV4L9MzLlFZCN6ZnU1Y9joQXMA6uh7iCKuz
   f25Ge8H6B1ZAycugVAwCfF/19f4sB1sI3VjMkcTYag0xSaIVe1HeAAhoZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="228097216"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="228097216"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 02:26:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; 
   d="scan'208";a="598799829"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 02:26:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nETrx-00GpLQ-JX;
        Mon, 31 Jan 2022 12:25:09 +0200
Date:   Mon, 31 Jan 2022 12:25:09 +0200
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
Message-ID: <Yfe5Bb3U6Uil7Y6g@smile.fi.intel.com>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-2-longman@redhat.com>
 <d99b3c4b-7b6e-529-6e4b-b91b65c92d81@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d99b3c4b-7b6e-529-6e4b-b91b65c92d81@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Jan 30, 2022 at 12:49:37PM -0800, David Rientjes wrote:
> On Sat, 29 Jan 2022, Waiman Long wrote:
> 
> > For *scnprintf(), vsnprintf() is always called even if the input size is
> > 0. That is a waste of time, so just return 0 in this case.

Why do you think it's not legit?

-- 
With Best Regards,
Andy Shevchenko


