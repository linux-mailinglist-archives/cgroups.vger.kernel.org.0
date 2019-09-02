Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0442AA5AE4
	for <lists+cgroups@lfdr.de>; Mon,  2 Sep 2019 17:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfIBP46 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Sep 2019 11:56:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36576 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfIBP46 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Sep 2019 11:56:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id o12so4476798qtf.3;
        Mon, 02 Sep 2019 08:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ExZmdHMEcHQFC7Ma718ILSpw2fAuwQcwKpYKAS2PKzU=;
        b=NBcl9afAeyIyBTtymn4baMsgwrbOW8VMDzEIyIBoQSV9u7cX7EYdGBRzis7ZX/ofpq
         Eiq5zWUgDS1gThudbRGxRuvdIUSdeecCrmUw079Af0u8M/E6FSRgmZHiOxsZjI5CBWG5
         xzSIJhkMt5d+lPpg9TlKK47Qatxcd6yQmdLH3uhmLr5L0t+3NMIx6cxkrVGeZt5TP/mr
         vka8smR3nHLaVPmLT0w4ERN8kHG9ccOolEdLvs33DjgmNHa4AuZJzswXawbOwoVCsPKO
         ccmuA9Kklssq36S2AsrmMchUiCxpSabHThI0e8Siu5IQ46aUHsDqRbCh4qQ+x/QRQ5jw
         DNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ExZmdHMEcHQFC7Ma718ILSpw2fAuwQcwKpYKAS2PKzU=;
        b=EhUa36szXeqWF/7q8rK8Kw/VG+MRzJ+IQ7UP2tKFFkmnMSA9LuGrQromN9w6NroEv+
         +OPPOLQ4BFKzXxQcUc0Dq10bR1HDm1pvE4vC1Wo6UbJxBBN0jznNpgh0HDEXCo7A+fV0
         Ut+sef1WSyPtbIBzgMY3jG/lqsVEweR+qkhjyn3RBJlVu2FJLPyYTuPv4bbQvPpknhMd
         pz1TiofwXw0j3KPNKx/7cH4155hNgiZ8Peg69e8TntKvvg1F1LIUvOFhUrd8Ax7Frbq6
         0XG/PZBKl/5ErRe/Zq/U/p9T0+3D+QySP1IzLDt8p1S3EeGYSqVALEr+g5OI4qF7UvRI
         V5DQ==
X-Gm-Message-State: APjAAAUHnq2MU9wGtQK4v2taed/0Cr+IDgAxqJh+6/o0X2J/Zhxa8MSb
        +EUxGDLHy0WHUzKJ1i2O96E=
X-Google-Smtp-Source: APXvYqxZPoOm1dNg+OLvFCqScXvp0FQHGzmfZw2XcPn98Gg1Hxy3v5Li17BKVh+KBJvgoi5M7BmC1g==
X-Received: by 2002:a0c:94a4:: with SMTP id j33mr18939469qvj.135.1567439816945;
        Mon, 02 Sep 2019 08:56:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4a24])
        by smtp.gmail.com with ESMTPSA id q42sm8430483qtc.52.2019.09.02.08.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 08:56:56 -0700 (PDT)
Date:   Mon, 2 Sep 2019 08:56:52 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, newella@fb.com, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dennisz@fb.com,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        bpf@vger.kernel.org
Subject: Re: [PATCHSET block/for-next] IO cost model based work-conserving
 porportional controller
Message-ID: <20190902155652.GH2263813@devbig004.ftw2.facebook.com>
References: <20190614015620.1587672-1-tj@kernel.org>
 <20190614175642.GA657710@devbig004.ftw2.facebook.com>
 <5A63F937-F7B5-4D09-9DB4-C73D6F571D50@linaro.org>
 <B5E431F7-549D-4FC4-A098-D074DF9586A1@linaro.org>
 <20190820151903.GH2263813@devbig004.ftw2.facebook.com>
 <9EB760CE-0028-4766-AE9D-6E90028D8579@linaro.org>
 <20190831065358.GF2263813@devbig004.ftw2.facebook.com>
 <88C7DC68-680E-49BB-9699-509B9B0B12A0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88C7DC68-680E-49BB-9699-509B9B0B12A0@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 02, 2019 at 05:45:50PM +0200, Paolo Valente wrote:
> Thanks for this extra explanations.  It is a little bit difficult for
> me to understand how the min/max teaks for exactly, but you did give
> me the general idea.

It just limits how far high and low the IO issue rate, measured in
cost, can go.  ie. if max is at 200%, the controller won't issue more
than twice of what the cost model says 100% is.

> Are these results in line with your expectations?  If they are, then
> I'd like to extend benchmarks to more mixes of workloads.  Or should I
> try some other QoS configuration first?

They aren't.  Can you please include the content of io.cost.qos and
io.cost.model before each run?  Note that partial writes to subset of
parameters don't clear other parameters.

Thanks.

-- 
tejun
