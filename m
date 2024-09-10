Return-Path: <cgroups+bounces-4810-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F080973AB1
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 16:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AAF2891CB
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 14:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4482F199936;
	Tue, 10 Sep 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w3RdYqLm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771851990C3
	for <cgroups@vger.kernel.org>; Tue, 10 Sep 2024 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725980160; cv=none; b=R5khzyNCLpAgT2hmAyhMbleO2U0MGvNzSTEr7G3JzzjWQoAd+yrMfteTa3kNBZKv393tD+xytD7QTtZw7iUVsmTXCM8skar6UY8r4qQH2pmXKEtTipXbUcHmo/enzzMkBBCcge/J/pSl4Bb/UFIJTmfhqYPEh7SltpdaIuh3voA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725980160; c=relaxed/simple;
	bh=LRKHhEG+UPUrru0gQJA2Slcgr3K1BQ2xzSCLu6g82rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsBvmrbyq99JCip4rLyXQE4ZwdvofSrXmojFff0ux0W9SbTRNh4dqvkRdvKF28SaLQqbLjOPqxbqt/QkMasTTcpUj+k1MONFgjFiQCjlwAjfR7uLR+R/PAQC8+SKcELQ60SJYHgCQC4sDEoX5JjC72AwU2cBsaJXnQ2dI+hDMBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w3RdYqLm; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-829f7911eecso337640439f.1
        for <cgroups@vger.kernel.org>; Tue, 10 Sep 2024 07:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725980157; x=1726584957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w0UcPXNBDPdAI3YKo5hRUr1yzJFMOK3YtStJSZ18Rfc=;
        b=w3RdYqLml4tbdiR27ZqgUGchmFYTY6g7/ck36TEmY6csPLiIQy1wO3zrspbP7/s1t6
         AgMlzLVc3El7VV7PI04ji2roie5VBviP7Aa9nIpJ2xbBM60j9CQ17aMgvmWEYxnnDaeT
         P50awePkrx77nxpo8YRdNLlX3Kcd2qMvcu0ClJ58dS47HCZoX01nvvuQuny4S5tQJ++f
         Bg26Gd4PgdZK8yEn+ahjYBkLc7nhrxVXSAA2EeqKNw/Oqjrh2JFA1XBMM7z6l6LK509R
         JQ0ZyeDXRErSkxqP8dFWv6iWaHaovfVAmgQA3p42Olv54D8DPHyhREfS6EXshPBdU8Yx
         VXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725980157; x=1726584957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w0UcPXNBDPdAI3YKo5hRUr1yzJFMOK3YtStJSZ18Rfc=;
        b=sOepD8mpllzGD4uO95lUOXhNckVghsv3tT7DKV8AaUGjEus/FAei6fLFJ6TYWoLQx8
         GIVkO6JPyU7eVOK2aHwCNrI0kbzqtK7Rj0j14E+gGVwuqoqol+lZ5hJGcPdd4fTZTZsQ
         qrIswO5zGfjM33CGM1NT7ZF4xrlK3MwDNog/lB7X39Z5o0G3dDD5A2kWabwpLxr4hwhK
         wtk9EsWo3qbNhqYAY74mQ2JVtCbGgyigTK+LdDh/mdx3FhlMCdkuKiFocWMe51bNArlO
         zhTtHESbWrSJF8bty4yEyf7E7HhgxUKHFxmThPYxt54sXmB0H8a1JW2sdEUIsveVv9D0
         iMaA==
X-Forwarded-Encrypted: i=1; AJvYcCU+6eohOA10igUXQRsFR9ia724M3Xl/+hHtOgowdx20ldKVGZv126RwVFU9yCKtAwehloikkduq@vger.kernel.org
X-Gm-Message-State: AOJu0YzGFPp9XPFEMRtwTTUr8n/WMiSFcInJI8g8Uay9i9JyCAvmukHm
	4ZNcckwIKS29DCsGwy7PHBBbFEyk/r1RwyvCYBCQm0gfATlPw6GQPvYlZV7ofcU=
X-Google-Smtp-Source: AGHT+IFwciO5QAOs/QiVqDCZYsdUuwqBkWFwbfoOlmZLRRbNYyabu5+ctk3jZHmS95EKdBS9715lNQ==
X-Received: by 2002:a05:6602:14c9:b0:82d:8a8:b97 with SMTP id ca18e2360f4ac-82d08a84650mr111604239f.10.1725980157605;
        Tue, 10 Sep 2024 07:55:57 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82aa733a30asm207850639f.8.2024.09.10.07.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 07:55:56 -0700 (PDT)
Message-ID: <03b4c259-ab70-4a61-a428-82b0261752b5@kernel.dk>
Date: Tue, 10 Sep 2024 08:55:56 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] io_uring/io-wq: limit io poller cpuset to ambient one
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: asml.silence@gmail.com, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org, cgroups@vger.kernel.org, dqminh@cloudflare.com,
 longman@redhat.com, adriaan.schmidt@siemens.com, florian.bezdeka@siemens.com
References: <20240910143320.123234-1-felix.moessbauer@siemens.com>
 <20240910143320.123234-3-felix.moessbauer@siemens.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240910143320.123234-3-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/24 8:33 AM, Felix Moessbauer wrote:
> The io work queue polling threads are userland threads that just never
> exit to the userland. By that, they are also assigned to a cgroup (the
> group of the creating task).
> 
> When creating a new io poller, this poller should inherit the cpu limits
> of the cgroup, as it belongs to the cgroup of the creating task.

Same comment on polling threads and the use of ambient.

-- 
Jens Axboe


