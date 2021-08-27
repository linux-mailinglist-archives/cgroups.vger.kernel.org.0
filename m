Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D64F3F9628
	for <lists+cgroups@lfdr.de>; Fri, 27 Aug 2021 10:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhH0Idx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Aug 2021 04:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbhH0Idw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Aug 2021 04:33:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61994C0613CF
        for <cgroups@vger.kernel.org>; Fri, 27 Aug 2021 01:33:04 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b6so9146077wrh.10
        for <cgroups@vger.kernel.org>; Fri, 27 Aug 2021 01:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VtoCWVqLTV/heRDzLkHFfB6NsN56tLaUOwMyBzk6DsQ=;
        b=p/XqSfnZUooWAr8lgDeoBRdn3K1+CVOMlLcHv640+uENvSRHmZHL/Jgt4NXBeRRIQU
         9S6RPb4u0xmPpipOcWiNh7NacH3f3BaGFhl8BBDRVL2cylmQ205R5dzp4/iEci705arm
         eeXKeDNPCjU/T0lcP0GWvReSEMchHGSqNrjwY3Q5vpumbt1rClmdOUI4ZSdtFPX2aZm1
         mQdRkS3hP+lKNWwYmOJTM7wLs/I1e1Q3EgJVBWBxRqOIIDDkkKGQsaE5YYf8lSOs9i4a
         LOSebZMZ+Yylt+8h7WM1IMps85gmmCfO5RAcc2gh3nnfpdPWCNuAGvkDAIBujwTDFrq/
         38Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VtoCWVqLTV/heRDzLkHFfB6NsN56tLaUOwMyBzk6DsQ=;
        b=dKna3MGKZ3mZ4WwmRgWKUOPakC5cprbjEQ3FRxLXg7VyhueKmMn6KjiiXAefhc0aRH
         +M1f178Ws0Ian9+pnPo46GvD+83kVoaLce0SaQ80h4et/ka4cjBLdcfZNFU6JhKWXcdq
         8+hU6cCIji3hZgVgQ6bC5BpxgtIjnspKOCNVpF4OALNmZToLic9vXBBOCpkdmGEoxKxl
         jvBIIHg/oU1sorLR7InZq8IfdbE2NIfaH6rHbK3ykFpdnoscfmqKyyicXssV3dAk56Gh
         BNKpqMQaEOV56NRiKjOkzL1IOTVt5BR+FDpTMZVALnm0800mwVNFqTNGkVKcs4VHs5X/
         58OQ==
X-Gm-Message-State: AOAM531rSmySSUwxhJz+YaFQnYUNmydDndr8hxeXTjq9aOYOACIk3J1F
        IPOiHZWVLQ3jrmv7QQHbpq6IhA==
X-Google-Smtp-Source: ABdhPJxVx6afc47YInNnteHGfK0p5HZ4m/TugBVCsf93N3hJ3wlglrcgrmLCRpLOttrbzg2VTuJiIA==
X-Received: by 2002:adf:d081:: with SMTP id y1mr8969546wrh.148.1630053182963;
        Fri, 27 Aug 2021 01:33:02 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id h11sm12269724wmc.23.2021.08.27.01.33.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Aug 2021 01:33:02 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: BFQ cgroup weights range
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <YSfOhM9+uJ5/FzY2@mtj.duckdns.org>
Date:   Fri, 27 Aug 2021 10:33:01 +0200
Cc:     =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <72DB38C2-196C-4F55-B1A1-B8EA55667057@linaro.org>
References: <20210824105626.GA11367@blackbody.suse.cz>
 <EC36D67F-D7CC-4059-8D3B-E0E64DFC3ADB@linaro.org>
 <20210826131212.GE4520@blackbody.suse.cz> <YSfOhM9+uJ5/FzY2@mtj.duckdns.org>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 26 ago 2021, alle ore 19:25, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> On Thu, Aug 26, 2021 at 03:12:12PM +0200, Michal Koutn=C3=BD wrote:
>> On Tue, Aug 24, 2021 at 02:51:47PM +0200, Paolo Valente =
<paolo.valente@linaro.org> wrote:
>>> BFQ inherited these constants when we forked it from CFQ.  I'm ok =
with
>>> increasing max weight to 10000.  I only wonder whether this would
>>> break some configuration, as the currently maximum weight would not =
be
>>> the maximum weight any longer.
>>=20
>> Thanks for the reply. Let me form the idea as a patch (and commit
>> message) and discuss based on that if needed (+ccrosspost into =
cgroups
>> ML).
>>=20
>> -- >8 --
>> From: Michal Koutn=C3=BD <mkoutny@suse.com>
>> Subject: [PATCH] block, bfq: Accept symmetric weight adjustments
>>=20
>> The allowed range for BFQ weights is currently 1..1000 with 100 being
>> the default. There is no apparent reason to not accept weight
>> adjustments of same ratio on both sides of the default. This change
>> makes the attribute domain consistent with other cgroup (v2) knobs =
with
>> the weight semantics.
>>=20
>> This extension of the range does not restrict existing configurations
>> (quite the opposite). This may affect setups where weights >1000 were
>> attempted to be set but failed with the default 100. Such cgroups =
would
>> attain their intended weight now. This is a changed behavior but it
>> rectifies the situation (similar intention to the commit 69d7fde5909b
>> ("blkcg: use CGROUP_WEIGHT_* scale for io.weight on the unified
>> hierarchy") for CFQ formerly (and v2 only)).
>>=20
>> Additionally, the changed range does not imply all IO workloads can =
be
>> really controlled to achieve the widest possible ratio 1:10^4.
>>=20
>> Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
>=20
> Looks fine to me.
>=20
> Acked-by: Tejun Heo <tj@kernel.org>
>=20

Acked-by: Paolo Valente <paolo.valente@linaro.org>

Thanks for this improvement,
Paolo

> Thanks.
>=20
> --=20
> tejun

