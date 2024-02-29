Return-Path: <cgroups+bounces-1922-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEF786D09D
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 18:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283291F2511E
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 17:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1166A70AC9;
	Thu, 29 Feb 2024 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="oqCzNIow"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B985E082
	for <cgroups@vger.kernel.org>; Thu, 29 Feb 2024 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227712; cv=none; b=OT4Nw+8DCBtRe36xeCgrTsEkf4nel7is8DOhurMcJDs0pFodlxuEtjoZXfuiMZCDXliCocvpBcxp71bUQbInPdBeTAp256kTvaNv0EqJm8smtBioz1FJE4TSaWC0X57FQTcvGgiVwEpavJqqy5X9Lhya9wtzlsWJXOaqcD9I/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227712; c=relaxed/simple;
	bh=JCyPY+2H2H9JH0eSxRfDyCePtVoM/ThuWB71eEisOV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQwXzclJ9cybPcJo+u3+8UsLO9CM82ik+EV/JzTC3+u4e3KyFurEnFUFAzcWpMI10diNDPvjEwWLdxXMIWBrNr27wgnOUynbQc/B7tjEuNSMkegJ0pld87mPeDBlO7Xf8xkeD5gWmHmGFJ53jhLMA/Muwplcjk7uId2fu9Ub2ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=oqCzNIow; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3650c7e0dd2so4282705ab.2
        for <cgroups@vger.kernel.org>; Thu, 29 Feb 2024 09:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1709227710; x=1709832510; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GayN+X8J7ovaRo/2dK0cHYBG0oTMkImkXgaZdeCAAX4=;
        b=oqCzNIowhQRvnn9CnBPkxYSvS6JA64dnkKb9+pcVhbVhR2Z+B79KS+xI5zHGy2npiY
         2yJwr28qq8YqNFVgIJff/W9MKrbEo4QBtSYBTMjvL+QuwMKBlso2vk5ETfvaCBVudAJu
         8S9uleSz74th/sf0Vn5u7cnTvzcFGEN9JMXfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709227710; x=1709832510;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GayN+X8J7ovaRo/2dK0cHYBG0oTMkImkXgaZdeCAAX4=;
        b=UxnEFvM43JSo6HURctzPMcSiMlAMHqzDlMSJG9gwc4ikgQ8QJk/AmWy/N9RJ/H+qH3
         sjCFeGvuZSucpOcqhz4laU+7M9Cq1ZzVlKCcBktR3LSUxQUXz31jsuCkZnok5UtmssrG
         mpAChWZO/AXxWvSNzA4uky28Cz2t7vcgkqL9SAXxavi9XYsSV+xj6SlO1VcwkBg5zjk0
         tGq0cIsEiRqhEq9WOJr/ov+varjYt5adzJDp3MIX9fn4g1JU/SQ8jPedVZNrQukaXZlE
         +fzr9aKKgMz00rgENbGy81v77Os/6oK1OPUA5ew55Iy1/AnGr9RUfUaIQslwKPumrckj
         /7eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgdK30VsZDVgSfkckgIpHcmlkt57xBXRcl3UT3yhK5/zxgOdZEob3Ff7DmvmX97OmMYpL5v/R0NvCX/CdzvZFdDO+tAqToDQ==
X-Gm-Message-State: AOJu0Yw1Q7eC6eKq+7CK3peInIZ+32aaaxSERpU7dVWBw57CFiqAXHLS
	QbvwU3v+Nf8RGXz6TkaSFLD3L0025Mg3SCRsHXXo1cK+r/NwLq66GwWWYFtIra4=
X-Google-Smtp-Source: AGHT+IE6DVKXs+ONq+UJC41B+TKExdNvvvYgvJ2+N0XGM1y9vHKHm0Fjxak123t/fQAzCDQLIqTaxw==
X-Received: by 2002:a92:c563:0:b0:363:d88e:e111 with SMTP id b3-20020a92c563000000b00363d88ee111mr3789803ilj.30.1709227709984;
        Thu, 29 Feb 2024 09:28:29 -0800 (PST)
Received: from localhost ([2620:10d:c092:600::1:1633])
        by smtp.gmail.com with ESMTPSA id j26-20020a056e02219a00b0036431524782sm425517ila.43.2024.02.29.09.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 09:28:29 -0800 (PST)
Date: Thu, 29 Feb 2024 17:28:27 +0000
From: Chris Down <chris@chrisdown.name>
To: Yu Zhao <yuzhao@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@fb.com,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: MGLRU premature memcg OOM on slow writes
Message-ID: <ZeC-u7GRSptoVqia@chrisdown.name>
References: <ZcWOh9u3uqZjNFMa@chrisdown.name>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZcWOh9u3uqZjNFMa@chrisdown.name>
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi Yu,

Following up since it's been a few weeks since I reported this. If MGLRU does 
not handle writeback pressure on slow devices without OOM, that seems like a 
pretty significant problem, so I'd appreciate your opinion on the issue.

Thanks,

Chris

