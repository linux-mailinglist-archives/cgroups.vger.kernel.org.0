Return-Path: <cgroups+bounces-4695-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCC396BF14
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 15:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CAA4B26384
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 13:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069B31DA10D;
	Wed,  4 Sep 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WJ6w3pf6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334431EEE4
	for <cgroups@vger.kernel.org>; Wed,  4 Sep 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457772; cv=none; b=KYHEWlhQyCoysEjW+V7iRgqy0VmF6r4qNdfCsrK624vPk2ZzdGXG2cpq0hSSVeblY6JxPX7LLVcyLTeT+9OB09XNwTuKXHS8gWIhyLfSg2Kei6c/SEReBZ88oF0eEIqEWO9cf1tPbOPhyx8g0wG1t4iqUl6bp8tFMjvomHtXHF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457772; c=relaxed/simple;
	bh=YMNwSkqEJW9uN7bSMftt+qatI3avzVnQiPt2E71884o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqY2XaJEH6Yv6JkW06jDtb4hSGUIearI1cJaewcP0hyhAj/z9Tv4PZCWCx0LM5q4ZDeiu64ZUM+SSaDbPHM2pc8RxrBWbDJEyeH7GTqVLuaFB3j4dvcHEzHYqgGH4bEM2ANc+jjPLE+GpMJmC8Xm8/PXkjiB8664mM4sKmmtopQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WJ6w3pf6; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82a73aad00bso55868239f.2
        for <cgroups@vger.kernel.org>; Wed, 04 Sep 2024 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725457769; x=1726062569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3OzM6yNBga43RZi596yJbd4sFGmjuH68EJYXdCc694=;
        b=WJ6w3pf6W8VidYgqQ953quYRg0VvCiE/ixf2+h67LNBe0Ot2QZI/1TgIWEIJ4piM2L
         mfAC+w2YRvJxKtWaUvHxFtdH1exmdayQHPsu5+HTCuyEaQYBqjivjB6f8QQ05MhrGJQm
         YnfAPjq5TXMjHxdJzV18/htxDuRx9G0rub9qjtF04EhhlaHo4K3g2738KVAmsUkzx+Dc
         fOMNDL2JuS9hy8TiC3ZjzvZrOP7eE8hX4nbeRD5heka621SuN6zS3n17829WSLW0v+oe
         rka55tlb9pWROWbOIqUp4jIRaWRdePL7ItHL9ns0TPwYva/ilmVJWjQuKezxP7K41NX2
         DQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725457769; x=1726062569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3OzM6yNBga43RZi596yJbd4sFGmjuH68EJYXdCc694=;
        b=RMOa1dvE99DvHawuPRAoDk9qk7PeTe5bUhBuBw4lNTjyPXG+u06pFJrmgNo+MY5aDs
         i7upDI4ztcLBklBUrYuDQN3GUiK77veLk3z5m4AbliDU0cLXsDTIP66u5ci01x+7kwPA
         xgevDkngsC/8P2vvt9X4rGq29V+9YAankqBOV+zzgfMRCp0jlQXI7SHljZoYnCzn90cW
         hh5d4uwUK6widc6HqHq5FkYa5rVQnFSfSa0zNIxPz5AMK1Ng3bgUX2pqBMT1BAljPodH
         OfnX52m+Chr1lyRcW3OSWwCXn9jj2u0XTS1e0Br2wpnWfcN1sYwp58+2TYEBvvxs3a+T
         /TlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuZYwPF6gjhaQfF5U5zTF3HmDdNs9eUXmi7sS0y2Nht7wHymnR6zEz/nQhg4E4uJw1GnHOdz1E@vger.kernel.org
X-Gm-Message-State: AOJu0Yywe4rGd+Ph5+LSwWTw0i7sqHsri6PK3j05abzwRXN6XzYRTlUb
	X6qEKwxqA0PG3WSmqt50NsgbcXgn8OlH6jdDLSrJPpSFAtKztYJEf6b/ZYN9zbc=
X-Google-Smtp-Source: AGHT+IH2T9+Rvn5lvq34B/1/vEVjOaoiI5vLsNmFeQ2xw9WWhAETa9+lwOKBoTbedzjte9E4G4daJg==
X-Received: by 2002:a05:6e02:180e:b0:39b:3a44:fe8a with SMTP id e9e14a558f8ab-39f6a97897fmr86244235ab.4.1725457769293;
        Wed, 04 Sep 2024 06:49:29 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d05da81bc9sm351855173.104.2024.09.04.06.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:49:28 -0700 (PDT)
Message-ID: <c7d9d97b-991c-4b84-a99a-60473f8ce929@kernel.dk>
Date: Wed, 4 Sep 2024 07:49:27 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.12 0/4] block, bfq: fix corner cases related to bfqq
 merging
To: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, paolo.valente@unimore.it,
 mauro.andreolini@unimore.it, avanzini.arianna@gmail.com,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
 <2ee05037-fb4f-4697-958b-46f0ae7d9cdd@kernel.dk>
 <c2a6d239-aa96-f767-9767-9e9ea929b014@huaweicloud.com>
 <20240904122953.fkwyfsfwhrwwmnbs@quack3>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240904122953.fkwyfsfwhrwwmnbs@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/24 6:29 AM, Jan Kara wrote:
> On Wed 04-09-24 09:32:26, Yu Kuai wrote:
>> ? 2024/09/03 23:51, Jens Axboe ??:
>>> On 9/2/24 7:03 AM, Yu Kuai wrote:
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> Our syzkaller report a UAF problem(details in patch 1), however it can't
>>>> be reporduced. And this set are some corner cases fix that might be
>>>> related, and they are found by code review.
>>>>
>>>> Yu Kuai (4):
>>>>    block, bfq: fix possible UAF for bfqq->bic with merge chain
>>>>    block, bfq: choose the last bfqq from merge chain in
>>>>      bfq_setup_cooperator()
>>>>    block, bfq: don't break merge chain in bfq_split_bfqq()
>>>>    block, bfq: use bfq_reassign_last_bfqq() in bfq_bfqq_move()
>>>>
>>>>   block/bfq-cgroup.c  |  7 +------
>>>>   block/bfq-iosched.c | 17 +++++++++++------
>>>>   block/bfq-iosched.h |  2 ++
>>>>   3 files changed, 14 insertions(+), 12 deletions(-)
>>>
>>> BFQ is effectively unmaintained, and has been for quite a while at
>>> this point. I'll apply these, thanks for looking into it, but I think we
>>> should move BFQ to an unmaintained state at this point.
>>
>> Sorry to hear that, we would be willing to take on the responsibility of
>> maintaining this code, please let me know if there are any specific
>> guidelines or processes we should follow. We do have customers are using
>> bfq in downstream kernels, and we are still running lots of test for
>> bfq.
> 
> That would be awesome. I don't think there's much of a process to follow
> given there's not much happening in BFQ. You can add yourself to
> MAINTAINERS file under "BFQ I/O SCHEDULER" entry and then do your best to
> keep BFQ alive by fixing bugs and responding to reports :) I'm not sure if
> Jens would prefer you'd create your git tree from which he will pull or
> whether merging patches is fine - he has to decide.

The usual process is that you start actually maintaining it, and after a
bit of a track record has been proven, then add the maintainers entry.
Too many times people start by adding a maintainers entry and then don't
really do anything. Not saying that'd necessarily be the case here, but
maintaining first and then adding an entry down the line seems like the
better approach.

I prefer people sending patches, as there's less risk there for messing
it up. Maintaining a git tree may seem easy, but lots of people end up
messing it up, particularly as a new maintainer.

-- 
Jens Axboe


