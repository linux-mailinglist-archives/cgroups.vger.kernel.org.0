Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD7ED6634
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2019 17:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbfJNPgt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Oct 2019 11:36:49 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33784 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbfJNPgt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Oct 2019 11:36:49 -0400
Received: by mail-qk1-f194.google.com with SMTP id x134so16289565qkb.0;
        Mon, 14 Oct 2019 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8ii9GkNQF57widzi6dRQGr51T/dzE7TsndlvaF7OsW8=;
        b=r1TO/YMWXsi2uiW+1nZxHeJZZ6OXIRuaRETVasx1CAn06XE1RDJfK1Akh0taYLNLPH
         JMdUrX5bmQUzVgVEv4iIHHeGkzbKaQkhzczAKS2UgPYO2t7pszXFgfrQet4Rml1jsyxs
         AJbDw+tDMuXcaOPa6yVAWIdeBIVOwv4Ei9P9g4++4S4/UIRzupP3Hlz1JeryH5qm/7I8
         +C4FHUYG+OPRZawTdTYsxKlh94IIfKXBthPSIjjBPSv2TPI1+7ChXXOyN0TfBUA7IZla
         xCXkLpuG05dKVSESBXZd45ZGGBjecBoxM/E9MltjLyhoStrluNpQh1sh1oC7XQT0FcJR
         dmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8ii9GkNQF57widzi6dRQGr51T/dzE7TsndlvaF7OsW8=;
        b=PdwYkaEJ4mztepLc1vDCVccp6GiwB7TDC4u+unfy3VMPiwmDuU2XQYp3TQ60x/BSwJ
         hnmZTi0L8ovYQ0qoLtbV/In3X51j23zb0lNjaZV1nFVPE3RFHBlXmVlvgQR6QLD188Ri
         lav+bDRWiQxjE9bs4Dzbg5SoEpT1qf++IdXb/MMSQO7mAmtte3tPEPOYbXMZs9YEU1Vw
         nH+OVBD4tPurWQ6kv/fZ1vPrgMVu6bY/KOQM3S8HEQ0Pa6/HNPZ9/eHsr779x3+8p3/8
         kAcAPaMiFAQ1fp2sTPBFLvdzY6pZB3X/VbyMs7SSb0eQA2wCCA+AyV5hwulpHrwdiHNz
         bhFQ==
X-Gm-Message-State: APjAAAVbW90bUzQGRgqCNRCXvS/a3Qfa2c8P424KG4rmwOGtcCn95GQn
        8bVe9CMu26tAq9hhN33tly4=
X-Google-Smtp-Source: APXvYqzAsrcnF+JJ/I0dg3MAHDz0lpPNCmFZN0NmQcLIo25p98r4L0YJFw/GPUXl0zTzDuogP8QvyA==
X-Received: by 2002:a37:e50f:: with SMTP id e15mr30253159qkg.192.1571067407828;
        Mon, 14 Oct 2019 08:36:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:50c5])
        by smtp.gmail.com with ESMTPSA id h68sm8292326qkf.2.2019.10.14.08.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 08:36:46 -0700 (PDT)
Date:   Mon, 14 Oct 2019 08:36:43 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     hannes@cmpxchg.org, clm@fb.com, dennisz@fb.com,
        Josef Bacik <jbacik@fb.com>, kernel-team@fb.com,
        newella@fb.com, lizefan@huawei.com, axboe@kernel.dk,
        Paolo Valente <paolo.valente@linaro.org>,
        Rik van Riel <riel@surriel.com>, josef@toxicpanda.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] blkcg: implement blk-iocost
Message-ID: <20191014153643.GD18794@devbig004.ftw2.facebook.com>
References: <20190828220600.2527417-1-tj@kernel.org>
 <20190828220600.2527417-9-tj@kernel.org>
 <20190910125513.GA6399@blackbody.suse.cz>
 <20190910160855.GS2263813@devbig004.ftw2.facebook.com>
 <20191003145106.GC6678@blackbody.suse.cz>
 <20191003164552.GA3247445@devbig004.ftw2.facebook.com>
 <20191009153629.GA5400@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191009153629.GA5400@blackbody.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Oct 09, 2019 at 05:36:29PM +0200, Michal Koutný wrote:
> Because I'm not fully convinced using the root cgroup for the latter is
> a good idea and I don't have a better one (what about
> /sys/kernel/cgroup/?), I'd like to question the former to potentially
> postpone finding the place for its parameters :-)

Yeah, I mean, I don't know.  If these params were useful outside
iocost controller itself, under /sys/block would be a better place but
it's kind tightly tied to vrate.  We likely can talk on the subject
for a really long time probalby because there's no clearly technically
better choice here, so...

> On Wed, Aug 28, 2019 at 03:05:58PM -0700, Tejun Heo <tj@kernel.org> wrote:
> > [...]
> > Please see the top comment in blk-iocost.c and documentation for
> > more details.
> I admit I did't grasp the explanations in the cgroup-v2.rst, perhaps
> some of the explanations from blk-iocost.c would be useful there as
> well.
> 
> IIUC, the controls are supposed to be abstracted and generic to express
> high-level ideas and be independent of particular details.
> Here a bunch of parameters is introduced whose tuning may become a
> complex optimization task.
> 
> What is the metric that is the QoS controller striving to guarantee?
> How does it differ from the io.latency policy?

Yeah, it's kinda unfortunate that it requires this many parameters but
at least my opinion is that that's reflecting the inherent
complexities of the underlying devices and how workloads interact with
them.  Andy knows and can explain this a lot better than me but here's
what's we're working on:

For the cost model, the plan is to build a database of model-specific
model parameters which are loaded during boot.  The cost model
parameters are pretty straight forward to determine, so hopefully this
won't be too difficult.

For QoS parameters, Andy is currently working on a method to determine
the set of parametesr which are at the edge of total work cliff -
ie. the point where tighetning QoS params further starts reducing the
total amount of work the device can do significantly.  This would be
the neutral parameters to use for a given device unless there are
overriding latency requirements, so it's likely that this can be part
of the model-specific parameter set.

We're currently deploying the controller to a lot of machines and
gathering data to verify model accuracies and controller behaviors.
It's working pretty well already and once the methods become more
mature, we'll upstream them (whichever projects they end up
belonging).


> > [...] 
> > + * 2-2. Vrate Adjustment
> > + * [...] When this delay becomes noticeable, it's a clear
> > + * indication that the device is saturated and we lower the vrate.  This
> > + * saturation signal is fairly conservative as it only triggers when both
> > + * hardware and software queues are filled up, and is used as the default
> > + * busy signal.
> (The following paragraph is based only on naïve understanding of the
> block layer.) So the device's vrate is lowered, causing its vtime
> growing slower, i.e.  postponing issuing an IO later for all cgroups
> accessing the device. But what's the purpose of this? If the queues fill
> up, wouldn't be all naturally pushed back by the longer queue time
> anyway? And wouldn't slowing down the device's vtime just cause queueing
> elsewhere?

Nothing can issue IOs indefinitely without some of them completing and
the total amount of work a workload can do is conjoined with the
completion latencies.  Most IO devices have queue depth which is at
some level reasonable given the performance characteritics of the
device; otherwise, the device would develop a really fat pipe in it
which can frustrate various use cases.  On top, block layer adds some
limited amount of queueing to avoid command bubbles (2x qd, usually),
so, while definitely not stringent in any way, the queueing is already
regulated so that things don't get too crazy.

Regulating based on qd may not be enough for latency sensitive
synchronous workloads; however, for a lot of workloads such as reading
file contents or copying them which have in-kernel windowing
mechanisms, it can provide a reasonable level of protection to keep
the effectiveness of the windowing mechanisms without sacrificing
noticeable level of total work.

Thanks.

-- 
tejun
