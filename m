Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44E82C2826
	for <lists+cgroups@lfdr.de>; Tue, 24 Nov 2020 14:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388370AbgKXNgR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Nov 2020 08:36:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbgKXNgR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Nov 2020 08:36:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606224976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NmB+/CVA1mnMQlH6qVDGPxzbBFzcsBI6srHn67igccA=;
        b=gsV9KdM/YQkMxbJBYxOowUm3+1oWNEUVlQatMAZTy3tySUu90rTuYOtNtMoR8hmT3ElC1A
        kGyhRAAigowjx3Fwvv8HFIDlYSj01UQaGmfg9JMWgXwAGXG/DaaB7J5dh6y9mYAQkCj8fs
        mDSLFDs7mMI7SILqUHioJwuV4wy0W1w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-1WzWI7IlNf2DMajuy8SH9g-1; Tue, 24 Nov 2020 08:36:14 -0500
X-MC-Unique: 1WzWI7IlNf2DMajuy8SH9g-1
Received: by mail-ed1-f70.google.com with SMTP id o11so7993507edq.5
        for <cgroups@vger.kernel.org>; Tue, 24 Nov 2020 05:36:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NmB+/CVA1mnMQlH6qVDGPxzbBFzcsBI6srHn67igccA=;
        b=GF2kGgJQzWfB0uz8SfSGo2M2HU/7q7DLmLvd9Cttil6zJRoPCh0kvaYOTBx1wetDOL
         VA8A0lIh8e0x4Gc1bcDxUiFfjK0WcRcSiTSd1Wtn8n2vmY7grLStJ8c48pjM/cKZLvpK
         JNGo0j4WXqrdU9U3kXkUEIG4Xgn2IkVfbZ4NtiNzQhZ4r7ICnPSYAxGadQy7MOSg0vbL
         HvriC2ASI58c26sXY71yz7ZPdQG0XfqiTyQ8f+D7RCAE9hOz82jxTfD5uYxa7DbYJSui
         1kdKoBupnr+LSArGryppvIaScRQcmU6foFSjz/gZb4zmZ4BD9st4ZM09/A+1UHdreE4L
         5ChQ==
X-Gm-Message-State: AOAM5321ny3QNBjtoqEr+nGuIqpnM+I3ElRGw0asXq6X2qQsZFSvwWFh
        UkGj65tzQkLuhUP7hNGdQMF18Wco956NByKqIBmMrGDLgDa/UfN37sjoClnME1tflAT1o+bnrd3
        WiE9hcGS5v6h1rcsmzMegfLQ4Kflzcpki
X-Received: by 2002:a17:906:4154:: with SMTP id l20mr4250331ejk.96.1606224972733;
        Tue, 24 Nov 2020 05:36:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLgDbRxAg0TN/5K6JMqyzhfN/CF2RVQvZyZNIJ9qnPaKoz49FJ0/KWFYWQb2Ccdbt4ydh+BSG7gnj+/67GBf0=
X-Received: by 2002:a17:906:4154:: with SMTP id l20mr4250314ejk.96.1606224972551;
 Tue, 24 Nov 2020 05:36:12 -0800 (PST)
MIME-Version: 1.0
References: <20201124105836.713371-1-atomlin@redhat.com> <20201124112612.GV27488@dhcp22.suse.cz>
In-Reply-To: <20201124112612.GV27488@dhcp22.suse.cz>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Tue, 24 Nov 2020 13:36:00 +0000
Message-ID: <CANfR36hBxRsHV+JZfT6_RZRXBvCu0p=4xUOSxzco-BvrTEP37w@mail.gmail.com>
Subject: Re: [PATCH] memcg: add support to generate the total count of
 children from root
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 24 Nov 2020 at 11:26, Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 24-11-20 10:58:36, Aaron Tomlin wrote:
> > Each memory-controlled cgroup is assigned a unique ID and the total
> > number of memory cgroups is limited to MEM_CGROUP_ID_MAX.
> >
> > This patch provides the ability to determine the number of
> > memory cgroups from the root memory cgroup, only.
> > A value of 1 (i.e. self count) is returned if there are no children.
> > For example, the number of memory cgroups can be established by
> > reading the /sys/fs/cgroup/memory/memory.total_cnt file.
>

Hi Michal,

> Could you add some explanation why is this information useful for
> userspace? Who is going to use it and why a simple scripting on top of
> cgroupfs is insufficient.

Thank you for your feedback.

Indeed, one can use a command/script to manually calculate this.
Having said that, one that creates a significant number of
memory-controlled cgroups may prefer a quick, simple and reliable method
to generate the aforementioned data, for management purposes only.
As such, I thought this patch might be particularly useful.

Kind regards,
-- 
Aaron Tomlin

