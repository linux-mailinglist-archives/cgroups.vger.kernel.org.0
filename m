Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B431F17A895
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 16:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCEPMk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 10:12:40 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:40965 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgCEPMk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 10:12:40 -0500
Received: by mail-pf1-f169.google.com with SMTP id z65so2405620pfz.8
        for <cgroups@vger.kernel.org>; Thu, 05 Mar 2020 07:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YoKRP6AlFeZSOfeR+XgZTehlo3ejZ8ZBqovWas3AC9M=;
        b=ELuPVGg0BPJ6mcaWkfE2kiSvg/R06fO8lmsgdsuySM4AxISIXmGLz0EzmuVxc7bSp6
         sQTRznjEtDOjuiEUAy3ctm1M/iQQeUlNVR/MwfkkaYeqDyPLGN4i7b3VdyLv3C8NPrTJ
         3stTJaAydVP08CB7WZicv3VZhD3oktbPNZmCXkxLP39m3zej6YWWy2YN0WrJjlfcT95R
         WdvOxsIoD8G+SMTfPg1acQudilPUOLCjbRAO3fHNqG/PbGEUCPBjvkWF/13fCVUzc7Ed
         4t22NJ79hXUw6PghZD9O6eqTOhWOOzPKIEfEtbMp+iObuZP7w40AsaRBSWPWDdG/G1EP
         Rqiw==
X-Gm-Message-State: ANhLgQ3GiwkS90TgPbzUu7oo32nV7cT5BPd4Xoa5Fr3nuCreRVrcRTpe
        Y5mCjG8/SqPtrgNz1NkSxAEcCmMKXKmfNX4+fCg=
X-Google-Smtp-Source: ADFU+vtLX/tZ+/U3zSYl1Z2e0d2Tz1W1Qz1BeOzi0kSy5h2KSaRFqpVZI3PNZLWvYGXmyH8Faio3gexq2DacoY1zZJc=
X-Received: by 2002:a62:1dc6:: with SMTP id d189mr8952053pfd.153.1583421159293;
 Thu, 05 Mar 2020 07:12:39 -0800 (PST)
MIME-Version: 1.0
References: <d4826b9e568f1ab7df19f94c409df11956a8e262.camel@sipsolutions.net>
 <20200304163044.GF189690@mtj.thefacebook.com> <4d3e00457bba40b25f3ac4fd376ba7306ffc4e68.camel@sipsolutions.net>
 <20200305145554.GA5897@mtj.thefacebook.com>
In-Reply-To: <20200305145554.GA5897@mtj.thefacebook.com>
From:   Tejun Heo <tj@kernel.org>
Date:   Thu, 5 Mar 2020 10:12:28 -0500
Message-ID: <CAOS58YM-HtmxwD7Q7g6ZzGsOJ_vWjHwb=7qpUwuZQEdeRrBifw@mail.gmail.com>
Subject: Re: Memory reclaim protection and cgroup nesting (desktop use)
To:     Benjamin Berg <benjamin@sipsolutions.net>
Cc:     Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 05, 2020 at 09:55:54AM -0500, Tejun Heo wrote:
> Changing memory limits dynamically can lead to pretty abrupt system
> behaviors depending on how big the swing is but memory.low and io/cpu
> weights should behave fine.

A couple more things which might be helpful.

* memory.min/low are pretty forgiving. Semantically what it tells the
  kernel is "reclaim this guy as if the protected amount isn't being
  consumed" - if a cgroup consumes 8G and has 4G protection, it'd get
  the same reclaim pressure as a sibling whose consuming 4G without
  protection. While the range of "good" configuration is pretty wide,
  you can definitely push it too far to the point the rest of the
  system has to compete too hard for memory. In practice, setting
  memory protection to something like 50-75% of expected allocation
  seems to work well - it provides ample protection while allowing the
  system to be flexible when it needs to be. One important thing that
  we learned is that as resource configuration gets more rigid, it can
  also become more brittle.

* As for io.weight (and cpu.weight too), while prioritization is
  meaningful, what matters the most is avoiding situations where one
  consumer overwhelms the device. Simply configuring io.cost correctly
  and enabling it with default weights may achieve majority of the
  benefits even without specific weight configurations. Please note
  that IO control has quite a bit of requirements to function
  correctly - it currently works well only on btrfs on physical (not
  md or dm) devices with all other IO controllers and wbt disabled.
  Hopefully, we'll be able to relax the requirements in the future but
  we aren't there yet.

With both memory and IO set up and oomd watching out for swap
depletion, our configurations show almost complete resource isolation
where no matter what we do in unprotected portion of the system it
doesn't affect the performance of the protected portion much even when
the protected portion is running resource hungry latency sensitive
workloads.

Thanks.


--
tejun
