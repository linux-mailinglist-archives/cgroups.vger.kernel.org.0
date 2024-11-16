Return-Path: <cgroups+bounces-5591-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A609CFFC2
	for <lists+cgroups@lfdr.de>; Sat, 16 Nov 2024 17:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B884287430
	for <lists+cgroups@lfdr.de>; Sat, 16 Nov 2024 16:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B36F28684;
	Sat, 16 Nov 2024 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b="PAscLiRs"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F06A372
	for <cgroups@vger.kernel.org>; Sat, 16 Nov 2024 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731773051; cv=none; b=A+REzKk3+nP8AGV9sy2ahF6kjdlC+9v4lhJ/5hMBXvLD+2olkcypiZ1NGuvu0WNuAhk16eYi2U0+WkYuaAgCx4MmlWba0Wbuhr1uTCfMavrvJbIQzlPsf47xNVjBq54NPf0gi3F2N/6jUGOa6SgOG7DTgbFUj9JTzrVK6hyrWRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731773051; c=relaxed/simple;
	bh=J7/5V0i+veJ3VOfLm+GSqR6OGg4NMbsUn9rK5mPdnkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksBc0ik0UZ65GaE+dLr6twQMqfowOXhsJPVPXmv71x9rsaungrNJwKO51PQatwO4rBXIFk1f56QYYuoLEegkHr0jfunGHk+E3hshUqAcosv8F/7bHUOFvSVN8wRw8u9zvieGO8cJTRlTPDc3qgKBM2g0XibdKV8qexMrpdGXt6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=toralf.foerster@gmx.de header.b=PAscLiRs; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731773046; x=1732377846; i=toralf.foerster@gmx.de;
	bh=J7/5V0i+veJ3VOfLm+GSqR6OGg4NMbsUn9rK5mPdnkw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PAscLiRsrywIZTbVJm0yNq6ChPpFd6fmTWGrzRc67Jo98QKCevD1K/1el2LW6d+f
	 Hvj047Jy7R/jayAyg5RCI9X9qYAA4A5/KVswDG85TEyC+VKlaO07Pmx+vNLfoYHWC
	 rQH1bUcTAa8MTvP8w0j5OlQQ7EVv4GiqpSzFCGAkBEzUaEyTUqz1gluY6n4oxKSRv
	 mExrbV9iPro2Ce75Vk8TaM/4oJGPqHMNBwdRcopkDclYnhGR+5/w1qp8bqZdBDLZh
	 zdEP8QBwz1qf7r5tv2fa714COsiedFkr9B37hIUuioJWVo2zMFAvwExyhcC1Cqmkq
	 kPPiTz9ie1I5XquE4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.33] ([77.3.31.68]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMofW-1tUyag1v5o-00Wf9w; Sat, 16
 Nov 2024 17:04:06 +0100
Message-ID: <c77e4607-6710-4256-9aac-26251813450f@gmx.de>
Date: Sat, 16 Nov 2024 17:04:06 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: process running under Cgroup2 control is OOM'ed if its stdout
 goes to a file at at tmpfs filesystem
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org
References: <e0dccc65-3446-4563-8a0d-1ebda4bd7b81@gmx.de>
 <tuvclkyjpsulysyz6hjxgpyrlku5zuov6gyyhjzvadrqt4qpse@bwmb7ddutwzj>
Content-Language: en-US
From: =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Autocrypt: addr=toralf.foerster@gmx.de; keydata=
 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
In-Reply-To: <tuvclkyjpsulysyz6hjxgpyrlku5zuov6gyyhjzvadrqt4qpse@bwmb7ddutwzj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dfjtywgP741BvDaadJAfIvNLgJFUpT+vtKtDqK7JE/xQNSKZCqX
 d17v9bFqpHWFes25ClRegX8IIEcJvfZA6GlquphY/rrO1ND/RuK0ITs4eu0atzosaY2Elf9
 maxjJ3/pR12AKUYncEBp1+5l3JEJy5HLBlx/fC6cKeZxXThwNxmTTJQZtLiWrVw+8ZHAK/X
 8R2//Lm4PjqlYSjZU6k6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6tySPlg3z2o=;ec9+zKdjfseIt8bdzkO995uam2N
 6p0u2ifULh/Yeo19tX9E8Eh+gufRzdaWhCcc4VnS/fxD/rMDxLSkZX+plKx3lMpc1isubXjfY
 NBZioKFis9H+D2dEDFbRI2LIqgBqgYTN7h7GqhWJTrvcDRETPf1exvcoG/+SU/Ohys2SYxRIz
 NhP/W8BKoCPNy+V/FoPYh4DpuNNuWO2jGlPVA08/JqN4Fs2I/Uaj7735LbD/KKPmu6cFrS396
 53QZ1zdQLjIwHhijAibAPus6Jqsjk20iVGcsGftkmkj0fesUIMFmh9CEksagx96JO0Ejuv9z+
 SdBq/DmTg5yehmXrj5b2O5Mpg95dpFsDv1k//7Fb8vxisjj/gnQcw32PoySroRKoJPvOkHZOR
 /lBoILqMfusmZGoWkETAB/UZXXfX/5hmFyYstZeYF6aMdIvvX392SLh2GHUK6xI5Sbf2QPXLu
 Vwzwkq/NkLT7J1ErpZmBTEiDAziG2kCKCKZ7Tc7FldE0pVz9FEcHG3Ap5R0/i+2Mmovpu7+m7
 Ej2zX7NilBviT4HfkEKhLPq3YWGWx6Ki4c3akFbEMv+KqMjTCtS0TrI4S3UUVZpeZzyibRIhl
 mHH4F4Uyz7VyssH3g5f38ptfm2qZBc+IccYUKB+wn9EwQhUXA3NMtI7mBzHbalWVhUltF0hCE
 mGRQdjMcIRULUBV37YqvSNpB8CA7UNfGkFoFliIbfBmBUbj83AImjWC44KLH/5TVY5RRK8m8m
 DBlr8gSnGwA7eErHpEZPkcjFlgvoDPbn2nVwRWc9/mpz2uQbZiZ/9h1Mj6OO17occYwtAgm6r
 ne5neoD249Uu+1kJBZbhyEL4i0jp8G+eWYx2mToHHJsVaCaPgCWUmFxHppi5r/T5CkshE1mlh
 Rp8GChG/MrGcBDso6EQv2rrA5WF2xq8NmNa8gu7W0//V8+XfvmZ8mllwe

On 11/15/24 13:52, Michal Koutn=C3=BD wrote:
> Your reproducer disables swap, so there's no option to write out the
> anonymous memory. OTOH, regular page cache can be written out to the
> backing persistent filesystem and free up RAM.

Ah, thx!

I removed any limitation for memory.swap.max and have set memory.max to
the RAM which is needed for the fuzzer.
That should make it, right?

=2D-
Toralf

