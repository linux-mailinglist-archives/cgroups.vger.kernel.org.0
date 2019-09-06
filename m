Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9B1EAB498
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2019 11:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392855AbfIFJHW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Sep 2019 05:07:22 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:37164 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfIFJHW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Sep 2019 05:07:22 -0400
Received: by mail-wm1-f53.google.com with SMTP id r195so6184185wme.2
        for <cgroups@vger.kernel.org>; Fri, 06 Sep 2019 02:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bRNpTF+jlVTEA0th1ETWAk1qTJWN6Qeu8URjuG4vuw0=;
        b=g2/f8zaLtJ58LwSPZ4Fxp31XofUqLVy6CiLpQZDRxqfSFCkkkcQLmP2pN2lCr2Rvma
         iQJYDrF+zvyU/PUN6bEeU5c3tIgPkZfK545NpqirU+wuHQnRcG43TdxBmEC2cEZRwsiY
         rtFeoV8dRoYX1yt6xiu7gsSNbRo/a2xy2lLe+bnBCfBxMj1ZL9K1yYgTC0JgUyLrQ8Up
         SGrBhpTBm62GcF/Xcwdw5RbV4mP9XNKsL94XLYOL+Z65LESWw2zQzD1bbFKib96Bk+9s
         KAaQoiygmpBNgES7OYeyQdBSdamFxGxMR9Rl/R6obORIq2TlsRfCcMnN7w819OT00gC7
         vLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bRNpTF+jlVTEA0th1ETWAk1qTJWN6Qeu8URjuG4vuw0=;
        b=d8tlUGPo3RhuZWv3ifBCSDhefxlO6fxmlqS5YLVOsaGGKYHE6tvjfrl28VjbnAnI/p
         WgCWmdF+yBOi0jxjyqBzrR1njl4snYYmEtDViTd2cZCjfvQXtlQHcuYeZRia5J9Nh+Aa
         x9FcJ5ExDenKSq2cSdQC8Duu25hQ390ZS5GS04hR+xJ6Zcib9XCNJclrb3waeht0gKhY
         eyvq7O4rMmPkCIZll9502lEXEysW/1LVIwq2pf0rNOke4sxGVz5YOjXKQbFpigId36vQ
         s/9UEXVKCyiT4XDXd1nPi7ACQV8QyM3NU4tv441ZDHVTPcFNNcMHfxfMNoT1aUIhwbjj
         Whrw==
X-Gm-Message-State: APjAAAU+gT9/1At7WrTxtSbAdGBpMcVNTB7bpilrC6Mc3wh2bZ8l8/t4
        N0VB/lrkxSU0pC5amrt+U1cCvg==
X-Google-Smtp-Source: APXvYqzTkSfIsU3hU/2q5f43wN5BDN/9Qf5vdBDJjz92GTwgZTlvkevjXpGIrHIxjNr/Bdt75k4Fig==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr6004171wml.35.1567760839881;
        Fri, 06 Sep 2019 02:07:19 -0700 (PDT)
Received: from [192.168.0.103] (88-147-65-157.dyn.eolo.it. [88.147.65.157])
        by smtp.gmail.com with ESMTPSA id j22sm9584317wre.45.2019.09.06.02.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 02:07:19 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCHSET block/for-next] IO cost model based work-conserving
 porportional controller
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190905165540.GJ2263813@devbig004.ftw2.facebook.com>
Date:   Fri, 6 Sep 2019 11:07:17 +0200
Cc:     Jens Axboe <axboe@kernel.dk>, newella@fb.com, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dennisz@fb.com,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        bpf@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <EFFA2298-8614-4AFC-9208-B36976F6548C@linaro.org>
References: <20190614015620.1587672-1-tj@kernel.org>
 <20190614175642.GA657710@devbig004.ftw2.facebook.com>
 <5A63F937-F7B5-4D09-9DB4-C73D6F571D50@linaro.org>
 <B5E431F7-549D-4FC4-A098-D074DF9586A1@linaro.org>
 <20190820151903.GH2263813@devbig004.ftw2.facebook.com>
 <9EB760CE-0028-4766-AE9D-6E90028D8579@linaro.org>
 <20190831065358.GF2263813@devbig004.ftw2.facebook.com>
 <88C7DC68-680E-49BB-9699-509B9B0B12A0@linaro.org>
 <20190902155652.GH2263813@devbig004.ftw2.facebook.com>
 <D9F6BC6D-FEB3-40CA-A33C-F501AE4434F0@linaro.org>
 <20190905165540.GJ2263813@devbig004.ftw2.facebook.com>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 5 set 2019, alle ore 18:55, Tejun Heo <tj@kernel.org> ha scritto:
> 
> Hello, Paolo.
> 
> So, I'm currently verifying iocost in the FB fleet.  Around three
> thousand machines running v5.2 (+ some backports) with btrfs on a
> handful of different models of consumer grade SSDs.  I haven't seen
> complete loss of control as you're reporting.  Given that you're
> reporting the same thing on io.latency, which is deployed on multiple
> orders of magnitude more machines at this point, it's likely that
> there's something common affecting your test setup.

Yep, I had that doubt too, so I extended my tests to one more PC and
two more drives: a fast SAMSUNG NVMe SSD 970 PRO and an HITACHI
HTS72755 HDD, using the QoS configurations suggested in your last
email.  As for the filesystem, I'm interested in ext4, because it is
the most widely used file system, and, with some workloads, it makes
it hard to control I/O while keeping throughput high.  I'll provide hw
and sw details in my reply to your next question.  I'm willing to run
tests with btrfs too, at a later time.

Something is wrong with io.cost also with the other PC and the other
drives.  In the next table, each pair of numbers contains the target's
throughput and the total throughput:

                  none                 io.cost               bfq
SAMSUNG SSD    11.373  3295.517     6.468  3273.892    10.802  1862.288
HITACHI HDD    0.026    11.531      0.042    30.299     0.067    76.642

With the SAMSUNG SSD, io.cost gives to the target less throughput than
none (and bfq is behaving badly too, but this is my problem).  On the
HDD, io.cost gives to the target a little bit more than half the
throughput guaranteed by bfq, and reaches less than half the total
throughput reached by bfq.

I do agree that three thousand is an overwhelming number of machines,
and I'll probably never have that many resources for my tests.  Still,
it seems rather unlikely that two different PCs, and three different
drives, all suffer from a common anomaly that causes troubles only to
io.cost and io.latency.

I try to never overlook also me being the problematic link in the
chain.  But I'm executing this test with the public script I mentioned
in my previous emails; and all steps seem correct.

>  Can you please
> describe your test configuration and if you aren't already try testing
> on btrfs?
> 

PC 1: Thinkpad W520, Ubuntu 18.04 (no configuration change w.r.t.
defaults), PLEXTOR SATA PX-256M5S SSD, HITACHI HTS72755 HDD, ext4.

PC 2: Thinkpad X1 Extreme, Ubuntu 19.04 (no configuration change
w.r.t.  defaults), SAMSUNG NVMe SSD 970 PRO, ext4.

If you need more details, just ask.

Thanks,
Paolo



> Thanks.
> 
> -- 
> tejun

