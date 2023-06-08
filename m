Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2517B7282B4
	for <lists+cgroups@lfdr.de>; Thu,  8 Jun 2023 16:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjFHO1p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Jun 2023 10:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbjFHO1o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Jun 2023 10:27:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2F52D53;
        Thu,  8 Jun 2023 07:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686234439; x=1717770439;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AOHF8Rb86ntesAI/yE6eOPe27CYMX9ghGd4LAdbYQLs=;
  b=FkS2ZiNKdRzafecRs5vfoQum0utUn6s8Qgs4pzsCv5c7XJNAcBQVdKjH
   KXWjjUihSYegMQrUzV4kdoLWqVZFOyXOeEI6afZEAT/rsrLNW40IRoIgQ
   G4gC2FBMA9dkx+nY7qSLJIgBD77Vt0kadshfZDsCeL8wES+1uwAyj13ap
   Zrom0wwnbG2SEhqO7j1cyyyx/P8yKBBHNOd/j5rUP3tewm8cW8e2uj9Dx
   oYPRUwckeGD9fZoMzP0ovqWkPOWBmvYvLBQ+VHqJl1+MzAjwmV8+jNkMI
   TSviLiIWm3PTNmL1EALH0wmmSqpIE37m9VcyTlDIfAD81M60/f45Sxi73
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="356177428"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="356177428"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 07:26:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="956736343"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="956736343"
Received: from rirwin-mobl3.ger.corp.intel.com (HELO [10.213.239.227]) ([10.213.239.227])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 07:26:28 -0700
Message-ID: <77587046-aede-f625-6a35-55bf9c5f1179@linux.intel.com>
Date:   Thu, 8 Jun 2023 15:26:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 02/10] drm: Update file owner during use
Content-Language: en-US
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Brian Welty <brian.welty@intel.com>, Kenny.Ho@amd.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@chromium.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Dave Airlie <airlied@redhat.com>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, "T . J . Mercier" <tjmercier@google.com>
References: <20230314141904.1210824-1-tvrtko.ursulin@linux.intel.com>
 <20230314141904.1210824-3-tvrtko.ursulin@linux.intel.com>
 <CACvgo52Bb3kBua8dh+eac6dhSwiJLMGAdGDAa+LQYoOwCLPLNA@mail.gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <CACvgo52Bb3kBua8dh+eac6dhSwiJLMGAdGDAa+LQYoOwCLPLNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 21/04/2023 13:13, Emil Velikov wrote:
> Greetings everyone,
> 
> Above all - hell yeah. Thank you Tvrtko, this has been annoying the
> hell out of me for ages.

Yay!

> On Tue, 14 Mar 2023 at 14:19, Tvrtko Ursulin
> <tvrtko.ursulin@linux.intel.com> wrote:
>>
>> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>
>> With the typical model where the display server opends the file descriptor
>> and then hands it over to the client we were showing stale data in
>> debugfs.
> 
> s/opends/opens/

Thanks!

> But as a whole the sentence is fairly misleading. Story time:
> 
> The traditional model, the server was the orchestrator managing the
> primary device node. From the fd, to the master status and
> authentication. But looking at the fd alone, this has varied across
> the years.
> 
> IIRC in the DRI1 days, Xorg (libdrm really) would have a list of open
> fd(s) and reuse those whenever needed, DRI2 the client was responsible
> for open() themselves and with DRI3 the fd was passed to the client.
> 
> Around the inception of DRI3 and systemd-logind, the latter became
> another possible orchestrator. Whereby Xorg and Wayland compositors
> could ask it for the fd. For various reasons (hysterical and genuine
> ones) Xorg has a fallback path going the open(), whereas Wayland
> compositors are moving to solely relying on logind... some never had
> fallback even.
> 
> Over the past few years, more projects have emerged which provide
> functionality similar (be that on API level, Dbus, or otherwise) to
> systemd-logind.
> 
> 
> Apart from that, the commit is spot on. I like the use of rcu and the
> was_master handling is correct. With some message polish this commit
> is:
> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

Are you okay if I just paste your very fine explanation verbatim, with 
credits?

> I also had a brief look at 01/10, although I cannot find many
> references for the pid <> tguid mappings. Be that on the kernel side
> or userspace - do you have any links that I can educate myself?

TGID or thread group leader. For single threaded userspace TGID equals 
to PID, while for multi-threaded first thread TGID equals PID/TID, while 
additional threads PID/TID does not equal TGID. Clear, as mud? :) My 
POSIX book is misplaced somewhere having not consulted it years... :)

Regards,

Tvrtko

