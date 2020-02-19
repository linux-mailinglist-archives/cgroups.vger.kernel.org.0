Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F5416485C
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2020 16:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgBSPTZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Feb 2020 10:19:25 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:37388 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBSPTZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Feb 2020 10:19:25 -0500
Received: by mail-qk1-f172.google.com with SMTP id c188so438187qkg.4;
        Wed, 19 Feb 2020 07:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SUXofl/MO5dWKqPfuAcBzgvKEpVFwkTb4AVbcHvWhdc=;
        b=qPicIwGzMD/HopbeCVkjoisZLYQAfbLcyi1p0R1hAaHnso/AF0eu8g8vXlN6X9FEtL
         7fECFrXeR75PQ2/4EVbfDkXZbWXLnCZr7B4njrFd2xev//SFJ56qpIS7cTAGwLOppIW+
         6QoIEKm0kuX4X1tDUjofK4Xwep6ZNvUTyo3/6OkUYns5edz9MSvCBMcFqSaIEeLPNjYc
         jVK5cC7Qcho1lEs9bINnbQ/2tR+4alIRjxDZ/mm7X8VPxSrCXF1CXFjBGBewsAJyrwt1
         BBtqD47i/ja6Hd9VM80jRs/6hlKZn+c7PApQ4oKjv//RN+EflbPUKgkHwt4/RA+hrmHd
         IHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=SUXofl/MO5dWKqPfuAcBzgvKEpVFwkTb4AVbcHvWhdc=;
        b=HWAOpTO7ZNjNKwr2YAwDJfjuOeHSRSzsl3H7v1Iqmnk/VCy+1+NnLVVS4KuY7lbuvX
         70cOhi0yEN7SHaH1Mrd6D8mk7tfeTqsWxT3olHhHF0mm5Ddps26/GLxTjYFq7ob/dVDf
         FY4Cxpq2IWoZFiturh++kfxZP6OMQ4i+uHMkOIG24dW7qHhckysR69TRVVwNhID8OlwC
         IPCRX19/dNQqmLwdC2kLbDRQWMvqUuA7ZL/5QKXVX/bKYGJKiF9w4VLLI0wR281Jdy1H
         fevu+r4A8AyIkHxSzlA550i9tkpa4rs/AX7tL/hlwbO5amG0oDJYomLUvUTIfWZe+539
         V3Fw==
X-Gm-Message-State: APjAAAWu3e1f6qIrZG91bexIKj6Nt4PHB/5L4g6ROWijFMhBeJ+K/Eyy
        jfFMS1wOFaoAmuOaGbnwy+4=
X-Google-Smtp-Source: APXvYqz4XQB8eDF2DfUmb5+BpK601xOFtKM68l7/bbHY+fI8/esjoy0xFswzTchxq8tI/vgvXmPh7w==
X-Received: by 2002:a37:7245:: with SMTP id n66mr25311079qkc.202.1582125563903;
        Wed, 19 Feb 2020 07:19:23 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:e7ce])
        by smtp.gmail.com with ESMTPSA id o10sm117547qtp.38.2020.02.19.07.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 07:19:23 -0800 (PST)
Date:   Wed, 19 Feb 2020 10:19:22 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [regression] cpuset: offlined CPUs removed from affinity masks
Message-ID: <20200219151922.GB698990@mtj.thefacebook.com>
References: <1251528473.590671.1579196495905.JavaMail.zimbra@efficios.com>
 <1317969050.4131.1581955387909.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1317969050.4131.1581955387909.JavaMail.zimbra@efficios.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Feb 17, 2020 at 11:03:07AM -0500, Mathieu Desnoyers wrote:
> Hi,
> 
> Adding Tejun and the cgroups mailing list in CC for this cpuset regression I
> reported last month.
> 
> Thanks,
> 
> Mathieu
> 
> ----- On Jan 16, 2020, at 12:41 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
> 
> > Hi,
> > 
> > I noticed the following regression with CONFIG_CPUSET=y. Note that
> > I am not using cpusets at all (only using the root cpuset I'm given
> > at boot), it's just configured in. I am currently working on a 5.2.5
> > kernel. I am simply combining use of taskset(1) (setting the affinity
> > mask of a process) and cpu hotplug. The result is that with
> > CONFIG_CPUSET=y, setting the affinity mask including an offline CPU number
> > don't keep that CPU in the affinity mask, and it is never put back when the
> > CPU comes back online. CONFIG_CPUSET=n behaves as expected, and puts back
> > the CPU into the affinity mask reported to user-space when it comes back
> > online.

Because cpuset operations irreversibly change task affinity masks
rather than masking them dynamically, the interaction has always been
kinda broken. Hmm... Are there older kernel vesions which behave
differently? Off the top of my head, I can't think of sth which could
have changed that behavior recently but I could easily be missing
something.

Thanks.

-- 
tejun
