Return-Path: <cgroups+bounces-6109-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E1CA0BBBF
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 16:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172F53A2101
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2582124024B;
	Mon, 13 Jan 2025 15:25:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E8240233;
	Mon, 13 Jan 2025 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736781949; cv=none; b=pO414RsqKKYXEM0nLA1o0eZ59jMhKBxZzSIB2skBfD7V3U+PFKr3bI0W5qaMEv0VmYnWF+P5OigWXwlfVh6D+JtxfGcs+Zvktlupqc6iwT3MCqTMnbbcqG/SyckAMGA2wyVnmW1euJjypLZin2V9ry1Le9blCCa2CPUIpZZiunI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736781949; c=relaxed/simple;
	bh=KMwlARxmKnOvotcbx/V1C4iAQKBZzaVCkNBHM6+34O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClyguAkvSnMbLuxNJItjiIku0Bh0p2yqjs5g5YwQr27YhL+xXJ8OrGfVten4BylePsWp2PLpzqVmANcbqWvTvsyLiZbbuMyLdnVUJSVCpYmsk1G5fhVdbTAJ3CCLi0j/d2hCCJW5ZaCYuQBDaC6QIeO+6odas+Hs+bpUoSw32gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hehaorui.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hehaorui.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dccccd429eso35451006d6.3;
        Mon, 13 Jan 2025 07:25:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736781946; x=1737386746;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5yWmGsP9qeQShbxtxIuD/fR5roHjJ5s1gl1J2Jpnpk=;
        b=FNhILewsakRkS2BypkUP50KSRao+5YCSC6OcrJN6rQPdGAqlPH+QOfVzFHSo3LtGTO
         UoHbdLH2C34VBpILhUhVwt2BJYeBQMSxBXrFZI+4fE7vyIg/OYpzyfoi07BwFZyxCHwV
         dLSOEd+9MFHeFPGBgFFZ3wMJ+9nKCI7Hu3cwKlbtIo8pQN9Y4/2YprZIeYfUdwZFleHD
         6wPYFFROXFofd9bRz1kQqGKV2CmdK/pss/HG9TpBFZbs+k85l+Wr+Zp/IuOjR0D8Dq7K
         s4ljdUewS7gTio0bT5J/KQvsXGZBWw+ewzXKhomr9fwb1JqW6iS5tYQRtbVBMFqRDUnP
         8IPA==
X-Forwarded-Encrypted: i=1; AJvYcCX8sageuWjZyquSy+p8DlAmUOEUMqP/VOMSy+97s78WkHeXpQw94Bt67ET3perxtM0YdW3p1LgN+UBc7F8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu+ML8H8SUJNO2QVWc5+b5kiNkD9H6HJ6rcezFclLu1n8dG3Eq
	p9Vk1HiPD35f99QMJTE8ezajAboznC1SpV298m6sZPxfSZqrden1YVrlBWmAU/36zg==
X-Gm-Gg: ASbGncsv20sYw8nq7MS0q/he4HD/UVUGy78laqaHu25PyhyQgg+t3nWymyClo/IrYgR
	oVc4BbljR699Yg6Rv6XS+DQ7isOzRVgMiQbeoE7XuGLpm1m2Zd8P1JQvApwc/hEwB4uJlseTELC
	Q+YbDBNEXg0MTc7PJexeoy6pwhOUK192YTLGrW9F7On4mkDqMmW64FeCyLeaJbQP8bzV+F8+tGE
	CbdQWaOQjEkncMuZKYjujeF/XSebenuiJ7gUI4vPEx9/iixjSyBhHw7elugvGdcC1Gx
X-Google-Smtp-Source: AGHT+IGAEctog8qT0EU1AY0MdfUyb04sLP5VeSspe35hsQyu7yA5bZGmO5YYtbu+M/MHvylxGvQ2PQ==
X-Received: by 2002:a05:6214:21e1:b0:6d8:ada3:26d3 with SMTP id 6a1803df08f44-6df9b1d1e15mr349447246d6.9.1736781946309;
        Mon, 13 Jan 2025 07:25:46 -0800 (PST)
Received: from ?IPV6:2001:da8:c800:d6bc::777? ([2001:da8:c800:d6bc::777])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade72b92sm42123786d6.84.2025.01.13.07.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 07:25:45 -0800 (PST)
Message-ID: <9836acca-8e5f-4e57-b5ff-3e3caf8e1c2f@hehaorui.com>
Date: Mon, 13 Jan 2025 23:25:43 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] cgroup: update comment about dropping cgroup kn refs
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <u24aq62nmro4agt2t4wuckrijfl4l3xa6i5wggxygjeq3sffom@wgt3kuwjd3qn>
From: Haorui He <mail@hehaorui.com>
Content-Language: en-US
In-Reply-To: <u24aq62nmro4agt2t4wuckrijfl4l3xa6i5wggxygjeq3sffom@wgt3kuwjd3qn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Michal.


On 2025/1/13 21:34, Michal Koutný wrote:
> It seems you've read through the comments recently.
> Do you have more up your sleeve? (So that it could be grouped in one
> comments changeset.)

No, I have not find more right now. I'm just reading the cgroups code 
and happen to be confused by that comment.
I'm still reading about the cgroups code base though, so I'm not sure 
whether I will find more places that need to be updated.

Thanks,
Haorui He




