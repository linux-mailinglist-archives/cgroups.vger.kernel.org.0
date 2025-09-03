Return-Path: <cgroups+bounces-9637-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B0B411B4
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 03:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DEF054608D
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 01:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB401D63F3;
	Wed,  3 Sep 2025 01:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="fEroIQeQ"
X-Original-To: cgroups@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FB7198A11;
	Wed,  3 Sep 2025 01:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756861979; cv=none; b=LcpOGehMkA0p5+duLTxG/SXypyziU76MU9CVTu4B7iag2szZtpWM6lgKTr9vRzPkcpJiBTOeg02YRBjakvou0Vd99YwTtEhryCpak7gUnwKgYpDrsmj2rul5+D1Z3aqiUtN1t4+gPnuOqdrqjdSGCIpF3OxjFTMqaxi6TYuSxcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756861979; c=relaxed/simple;
	bh=2iy2ah6Yafa71eX0vIoEqc+ao38uwxFKbPdRudfdM6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7dpXi4V0lb5+2egdQysJu/h2qKks2hRO3U2CEti5jMhjViTX5mjSgkAoT/bxkgiaRQ+TTGpRBM8KEOeJ23kRv83qS2cbqfy60LxYNIGIsArWjG/puiLqcW08nl7yq0LQ2wgrHdpbmNmIFPL8Ioa30PEKHTdzVxVlbjTAxUCxVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=fEroIQeQ; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cGl3D4tD1zlgqxl;
	Wed,  3 Sep 2025 01:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1756861965; x=1759453966; bh=2iy2ah6Yafa71eX0vIoEqc+a
	o38uwxFKbPdRudfdM6s=; b=fEroIQeQMIr5oFtODtdP7B2aKIS82rbcgRepaqgv
	uUvSugkNxoCsKdOvFlrDm2jqhgtidZ4gmBoBYdiHg+9mV9SkQ0bP7rZt90t0cld2
	E7LFQ5W+xmLL/ggxDel+tnOvhCkvibFlQSK14bj46aNsoU3Vp2J6NZ2IPXgpmkZ6
	m7BEyhw9KfET8o6OtqcW2VrStqa8Mrvy0cLrq2DSNZ0Hn2XPVK6FH9yaBJhN60aG
	9/+h/wOvReaZfcDPPRcYlCSV/wdB2Hy0eM9xahb7pK4hTJfYq/AHcuySPPIa/UY9
	fIVXnMBYdN3KW4IHWcOpeQJ5pz0bx+qUFaiombu245qK8Q==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id f8BfbL6ksvXK; Wed,  3 Sep 2025 01:12:45 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cGl2d0bZRzlgqTx;
	Wed,  3 Sep 2025 01:12:23 +0000 (UTC)
Message-ID: <7edded3f-1075-4c14-9db9-a62adc0a4aa3@acm.org>
Date: Tue, 2 Sep 2025 18:12:20 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 14/15] block: fix disordered IO in the case
 recursive split
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com, axboe@kernel.dk,
 tj@kernel.org, josef@toxicpanda.com, song@kernel.org, kmo@daterainc.com,
 satyat@google.com, ebiggers@google.com, neil@brown.name,
 akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-15-yukuai1@huaweicloud.com>
 <e40b076d-583d-406b-b223-005910a9f46f@acm.org>
 <0f7345dd-8c6b-a75c-c234-2bb09f842069@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <0f7345dd-8c6b-a75c-c234-2bb09f842069@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 9/2/25 6:00 PM, Yu Kuai wrote:
> Hi,
>=20
> =E5=9C=A8 2025/09/03 1:20, Bart Van Assche =E5=86=99=E9=81=93:
>> On 8/31/25 8:32 PM, Yu Kuai wrote:
>>> -void submit_bio_noacct_nocheck(struct bio *bio)
>>> +void submit_bio_noacct_nocheck(struct bio *bio, bool split)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_cgroup_bio_start(bio);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blkcg_bio_issue_init(bio);
>>> @@ -745,12 +745,16 @@ void submit_bio_noacct_nocheck(struct bio *bio)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to collect a list of requests =
submited by a ->submit_bio=20
>>> method while
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * it is active, and then process=
 them after it returned.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0 if (current->bio_list)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio_list_add(&current->bi=
o_list[0], bio);
>>> -=C2=A0=C2=A0=C2=A0 else if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUB=
MIT_BIO))
>>> +=C2=A0=C2=A0=C2=A0 if (current->bio_list) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (split && !bdev_is_zon=
ed(bio->bi_bdev))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
io_list_add_head(&current->bio_list[0], bio);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
io_list_add(&current->bio_list[0], bio);
>>
>> The above change will cause write errors for zoned block devices. As I
>> have shown before, also for zoned block devices, if a bio is split
>> insertion must happen at the head of the list. See e.g.
>> "Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio=20
>> submission order"
>> (https://lore.kernel.org/linux-block/a0c89df8-4b33-409c-ba43-=20
>> f9543fb1b091@acm.org/)
>=20
> Do you mean we should remove the bdev_is_zoned() checking? I added this
> checking because I'm not quite sure about details in zone device, and
> this checking is aimed at prevent functional changes in zone device.

Yes, the bdev_is_zoned() check should be removed. I spent a significant
amount of time on root-causing and proposing fixes for write errors
caused by recursive bio splitting for zoned devices. What I learned by
analyzing these write errors is the basis for this feedback.

> So I don't think this change will cause write errors, the write errors
> should already exist before this set, right?

Agreed. Although I haven't checked this yet, if the bdev_is_zoned()
check is removed from this patch, this patch should fix the write errors
triggered by stacking a dm driver on top of a zoned block device if
inline encryption is enabled.

Thanks,

Bart.

