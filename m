Return-Path: <cgroups+bounces-4809-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E69973AAD
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 16:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D06BB2375A
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 14:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B6119994A;
	Tue, 10 Sep 2024 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oiQvIM3r"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F10D199931
	for <cgroups@vger.kernel.org>; Tue, 10 Sep 2024 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725980140; cv=none; b=uE1C5njnwWS+20p1O1tbSr31zA7HgdWl/Cmgzzsxvwe96mAOhI/Ape2QiYlzbz+Z6gfW1oz1fNhHs19wloyc5ZZEq/obRMj/9MOuC9ZdQqWgWCJ8zz2nyYvgW06eJiRmTF/uslTbUErcAPerwQ4WhQ4PydScBSl9UNCsEKfgSjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725980140; c=relaxed/simple;
	bh=h//wHtXRgtsnucxDoTRJMW20a6wxlz5iZ7J2mRsmAjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iv/IVvTQvD0JrD/XchO50o4KebJob+pxAtqIN9IyIxykvE1z09/+dV2jIDs/R18ST9CLmJ2d8K4DfV6H9Wq5QXXw3wkr3xeH7YlttygjG8DVHGBVeoMzvZtyhdniieCqL3aIpEG90JJQnq3yeI54huXvLrLyRU5hsbmlFGZ+zN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oiQvIM3r; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-82a626d73efso264281639f.1
        for <cgroups@vger.kernel.org>; Tue, 10 Sep 2024 07:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725980138; x=1726584938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Jv69Funzr32cFzMw3DAAVgqxxwV4rEJRwpwk5aDHb8=;
        b=oiQvIM3rfvlGbJ/2JJFPkbukDiasOrWpy2TtLv5AsvGDVsxM0ihZ0O4jY4fHlQvSVu
         l7IgMluN0dhVg1N6j0vhWj2W7KJXYoiMpDlfgN3hBKz6QAy7QP3HVCyghUbxkmm3ojoj
         iU2QYImfmnL2zNjvRjT7nQpG/cYNSTOzlFc0cljD6jaM8sC4UWfQUsmabR4XfOx03owo
         i/QZTaoriv9QAyxBL3Lbg32ouy+pzorv3AD5aIcFCFQJBG4fhV5dvkP/u6rRp5V91/H9
         I0UULUoV7JJ+eaBYIwn5PN/dAihI69w5PphbIY/pVM0bvqrAH/IcdGCWaTOgGuBnMIXO
         8A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725980138; x=1726584938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Jv69Funzr32cFzMw3DAAVgqxxwV4rEJRwpwk5aDHb8=;
        b=BWaeQSxjTN88TL9eZuBAEeiA2dQFfei/UMaohGmSGALaYiJwUZwNvhqDN/HLKmQ33w
         o7yZq7oTVkrNNMsV0U+MiPnma+JexekPZanJp7gITz6vHm73YayEJQeK8/BAlqbSX6MS
         GnDjwGA6NfdcG/2Vd0hHNHgMSZta2PFwaXyxRNf+LcBn5KhP1E+lW2S4pzdRz/yRGbmn
         ATA/+puy9Rc3iW2ZSNIRWgTKeqr/LW7IykHhdsJHqknoczSTYNnhn9LhkV0I44Hs0N5P
         9YkiGYSh1cAL464JhaEO0ezx5uDlehznlAIQQPka+Fs0mr21ci64b47zhqCeP3stZePS
         exhw==
X-Forwarded-Encrypted: i=1; AJvYcCWjEXf8g7V4QpQggIs4MszW/3Ywv1wS4HQmLtZpbgKzufw5kWEA0wjUTNx6AIf7zzm2pLiqmpZ3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9aQxN77zzKU0+E5IfxvV+nV6gBehjikWvGLqpGY4eyOqRencr
	RKJhdSvH5NJQHJBZidbDEDf3B9lpo72sjBu88/PpeAid3ODSeC/asZrF+/vl9V3dbuA41oJl3IP
	S
X-Google-Smtp-Source: AGHT+IF78iPjvZ2auF59LluRUlSBusRRQ9F/bB7+yzwd4gEwpZtiPuztOVVZuatoClcso9ip5RWRyA==
X-Received: by 2002:a05:6e02:1d82:b0:3a0:45d2:3e81 with SMTP id e9e14a558f8ab-3a04f0670e9mr183027975ab.4.1725980137675;
        Tue, 10 Sep 2024 07:55:37 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a0590161cfsm20423015ab.77.2024.09.10.07.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 07:55:37 -0700 (PDT)
Message-ID: <a0480aa7-4be5-49c5-a20a-3bdf936d29d4@kernel.dk>
Date: Tue, 10 Sep 2024 08:55:36 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] io_uring/io-wq: do not allow pinning outside of
 cpuset
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: asml.silence@gmail.com, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org, cgroups@vger.kernel.org, dqminh@cloudflare.com,
 longman@redhat.com, adriaan.schmidt@siemens.com, florian.bezdeka@siemens.com
References: <20240910143320.123234-1-felix.moessbauer@siemens.com>
 <20240910143320.123234-2-felix.moessbauer@siemens.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240910143320.123234-2-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/24 8:33 AM, Felix Moessbauer wrote:
> The io work queue polling threads are userland threads that just never
> exit to the userland. By that, they are also assigned to a cgroup (the
> group of the creating task).

They are not polling threads, they are just worker threads.

> When changing the affinity of the io_wq thread via syscall, we must only
> allow cpumasks within the ambient limits. These are defined by the cpuset
> controller of the cgroup (if enabled).

ambient limits? Not quite sure that's the correct term to use here.

Outside of commit message oddities, change looks good.

-- 
Jens Axboe

