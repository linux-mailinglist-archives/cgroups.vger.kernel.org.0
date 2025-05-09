Return-Path: <cgroups+bounces-8115-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEDDAB1F3B
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 23:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7744E0C0D
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 21:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB7721E0A8;
	Fri,  9 May 2025 21:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6nZugqk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CD142AB0
	for <cgroups@vger.kernel.org>; Fri,  9 May 2025 21:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746827198; cv=none; b=CmLacEc3AiUjJ5hc8QuWXgyPt1P8rGKgOia7DMvzkkRjN1e/D/inCWNl7O9XBqluh0I499A3ikKuMxdv1Bogj/HREoNw5vSioFvM7tyGvWO8JwGYUO0HVmEbdNkONz7bp8EVKg9Pnknd3Mezxac0BdYvqeaI4cDx1S4mUtFDs8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746827198; c=relaxed/simple;
	bh=Z1PckJi3YuMy2x729Rya61o0HfHkBGM4tCQRNbG5QLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vv6nukUf/Sy6UC68tyxZ5NzTKoPbUmSjOB5NsPqoy8mVc+UJhPH46Q8+WlyHobpSXPxbwgu+AygGL8GXnHXWV0XswbLHGKEl9RbqfxKXZhhif+wdkPcjJBbRjy1OBbe6QgiXju2ZuuEygUC13MWvy05waoGny/l1hAqoLztwicM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6nZugqk; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af5085f7861so1811708a12.3
        for <cgroups@vger.kernel.org>; Fri, 09 May 2025 14:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746827196; x=1747431996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/F7PRAcYypRqCE5vWOKYPdmOF+xTqopC6yWc1PsmpSw=;
        b=K6nZugqkBAyLH7nhoaAtskBgOf+S+iXRhf00IMnREerjeXepqX2v59FbmJaRYTElB6
         1P76oPCvwyqv5bRlU3Ju0T6xSo7WEyZkVRs+4D5lM8lPou+SKUnoKpKv28ninHNMb5wj
         WEuH3XulfWKCOSHH7Hi2mLzFYwUZG5ARv9DcTmXAli8VAr6U+9Ws/9dCqxxvsdt9S57c
         QytvaQNu4mzn++Uw1tdTmBYm6pVsL6dqd3iiZDVKUm4yKk7x+qYFkGA5OUB4k3Kl8tBo
         iQjAVglnNXL4EYIP2J4IKA9k/3m5LrtaGtyZMHd6c3+d+PjAc5rPjBzp6Yj3/KVwj3og
         bE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746827196; x=1747431996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/F7PRAcYypRqCE5vWOKYPdmOF+xTqopC6yWc1PsmpSw=;
        b=q6COoJxEmfrrP3xriC3lNuFGHuCzxAjTx8anpm1pd9+AMkc59eh8g6o8Bv64vuXZpC
         LWZRBAPEHk/ItA0sC2XZp3mfCiGsQ9ClAFcDs2l+p2EZ4pueRThH5J2CQ9qYSL+WsIIz
         sFCwE8QQdsbVgBnfFAf1RUfq+KXCrURkp0pLTNUB3n7/YTK7fSRLeRiwSIcO4wB/uCHY
         sMgVSu+U24rXpNC67pBSw8LLlbklc7gaVGEffBNXuQfQ+pCWdT47iSf5n8weeDJOzvf6
         lXeGpc/q64LnImPPay70vFZ5R5jh7RXbTMRGxfeSmViOJ2nCGlCV4QlDYPZqgSs0XpmX
         V0ng==
X-Forwarded-Encrypted: i=1; AJvYcCUGOOSQ46ONRtefRQ+Y9lKV5lKYQUflsIPSKqKwjX7dmBCaHcZXXUbxnQUXWgaJ5N1ceL/1ioZQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2MrZo7D0oHbLuziHY7zgmo2c1Zo9oDi7iqIWRozpVOfPDEQV3
	n0E+Mule5Rur+y7wwqGanQPhO8E9V2ZhcDzGqWwhMhEqwhQvTGgf
X-Gm-Gg: ASbGncvqYcPThdh20GCfGTYhS7xf7UycESWcN5SBHACItZSt10dKVMT9NacyOgue7Js
	nMdYUSKyV+pjcd39thRWNGTwYoO7Pux+Cd9J4yhdAZfzPfP8KEOrG91324guJKio0n4USfQx1pX
	HJfprNf2S5ZWXMj8/qAEjUT+Ly1gYjgLXPp3Glyixy8T+KSfBKwCQ/bDG1cYmjGWGsRLRzXPLC9
	eUEviizK025ny2RG2QrzT4bYVzkzcHh43oyWT7J2qh6BqOGMnhRBmhGKnb5f/R+oZDFHY/C3VM+
	4I+de5Wq8LPP50xIZTom2u28z1XYPeaqCEBucjU0f6B7/VExjv7nJpi6Em9F3pUdqLr5JBKxUES
	Z/MXYFVg2vOxVIF88xom0Kg==
X-Google-Smtp-Source: AGHT+IG9zQnokJXuA9u2+tJVGClPHs1sd6/yMcCMRzhZicwzP8I807ASKe19trZfZR0/nmAOsP8riw==
X-Received: by 2002:a17:903:2351:b0:223:2cae:4a96 with SMTP id d9443c01a7336-22fc918c11emr67459935ad.42.1746827196094;
        Fri, 09 May 2025 14:46:36 -0700 (PDT)
Received: from [192.168.2.117] (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c441aa492sm944385a91.1.2025.05.09.14.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 14:46:35 -0700 (PDT)
Message-ID: <bd99f815-6cec-4d7d-ac1f-0c06b41a34cb@gmail.com>
Date: Fri, 9 May 2025 14:46:34 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] cgroup: use helper for distingushing css in
 callbacks
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: tj@kernel.org, shakeel.butt@linux.dev, mkoutny@suse.com,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250503001222.146355-1-inwardvessel@gmail.com>
 <20250503001222.146355-2-inwardvessel@gmail.com>
 <aBshvNRl6fCGKVmS@google.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <aBshvNRl6fCGKVmS@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/25 2:02 AM, Yosry Ahmed wrote:
> On Fri, May 02, 2025 at 05:12:18PM -0700, JP Kobryn wrote:
>> The callbacks used for cleaning up css's check whether the css is
>> associated with a subsystem or not. Instead of just checking the ss
>> pointer, use the helper functions to better show the intention.
>>
>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> 
> I still think this should be renamed and potentially reimplemented to
> (also?) check css->cgroup->self, but anyway:

I'll make that impl change and rename within this patch next rev.

