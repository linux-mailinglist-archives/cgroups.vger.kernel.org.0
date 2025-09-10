Return-Path: <cgroups+bounces-9869-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B937B5151A
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 13:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B761B2214A
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 11:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1EF3176F2;
	Wed, 10 Sep 2025 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvjS5m7C"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC32130E0D9;
	Wed, 10 Sep 2025 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502719; cv=none; b=MDDIuCl2Jb7NmMgsENTl/6BSxd5DtE02pOjwfoAZWpS7sjnWLoDDqlr+VIY4j/NRY4iLcKiZSR3cUPVIhgZF4YeJsS2e6B3v1CQDfwGMiiH65Vc2OtaPUqnU77fEjtCH5Ij8aOEsTHhzSmYTqirRdlG4IV7Va3f35ay6DPJ9p9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502719; c=relaxed/simple;
	bh=HH9rNYiFPXzEBmEkHzbBpqhQvk+IcfDxvUnqhY5ubKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZ+rNOl5kGiDCu2xEgx66ZdaHs4sLD/LxsdfCszdkcJdIN86Juaoe+d/U7M2JOl2iw7W5IdfIGJ1jUDc6UKcinIaAr1LBeOqLK2hKA4lY7PfCR+CJE21mf1FG2OtCtTSCTm5AQai/6vFUH9Wx93kzr/PkpmPiv7sW6OPsEBtJ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvjS5m7C; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so463194b3a.1;
        Wed, 10 Sep 2025 04:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757502717; x=1758107517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OpfgucuvJDOycH0vvclXgaxAB2hhuLX8EhU4WrxRvag=;
        b=GvjS5m7CAz7ZF5BA3HcBLBVs0y7nh7vmNwsXs4lf4NCz65RZ6vNxAGD6QfjmihOcjK
         WPVs3sXMU6yXsR2z3Vx0SedWZM+Cdc669VxrFlYdD5TxY3qhh2KvBRsT4hrCQvK3SIbo
         E4M9Tn8sWdChmPvV2RZe7kw6IlY/4zLxgNBNru0Y7y4Dr4kar5A4j7aoj3Z6uXSnUkd0
         cyC0jfiPYQZpMvBvOqZcipnoraVPhBkKpB0+UKVTm9vEZh7dQqO99wEv0+8UACrT3Qqd
         tQCYHta64XOuhGPb/nqIaW+k2GLOHpndbbSA3lPCdryFENEfO6FPDXx7pAHut0xTbdue
         bL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757502717; x=1758107517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OpfgucuvJDOycH0vvclXgaxAB2hhuLX8EhU4WrxRvag=;
        b=TghE8H28s3zqsLIg2zb1i0RDH2UHmmib26hi2xQxCbG/oIBfJSHhJxWaFSOhdXJfPu
         RSa0sdh0d/Q+k0TxeZ4g3G+NKSHyK1G+wMeNrGtmUIBCO0dCh5VEHdyzVZrY3wMyUAx+
         fRtPAHD7UFCJSYwbqIb8qQC5/JipGO+sllRnWtsZz8F9rGwbxwctpsZOGEpewafVzkeK
         ECHalefDDbW73eb0lDofIOLVeg0ApPlIMweiB3SmV/UuC3ZS7tdxvG4V0a0PaBKgbzxF
         a/4ehqQD9QqYzt6rs3cqunjRmvgqMPEZ3nauRLhCCIM0oF2pBQ2vpJd4IjvRsYGBhJC0
         z4gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMMb0NHYjIf8DlE6TGmaUDzojk23h52pKHb3kJjsjWHdQJMH5vsULIqYAJzdmgDf9Doz8sesR07Rk5@vger.kernel.org, AJvYcCWlD2Gbxe71y5ojxf4zPsSP6s8ytkq3ayrRM2WIWY+ErCl9citzr8PWZlf0hp7h7WQ2cuDk+iGv@vger.kernel.org
X-Gm-Message-State: AOJu0YwKAL7McULMrutHdpFo2bpQ1Tt151T70xAxwJaUiiU6YF/sIdNf
	gO8o4a9IsohQKssNyKscADfIv6n7f2E0+/VZkAuUn6xp1jM3I5Bnh77Z
X-Gm-Gg: ASbGncvADWYnt8xeGLrI6MxEcNHqagfydHUac88YLdrnYwzW2t3uNiunaq9qJCgON9D
	duRfxGma0sT8/oPVYDF9nIbcIAout9SoTwl8+oTFgW/nMD/UeR3YQ/7o4tg08CmSmX9oZXmK0+l
	zqjphQWQHhYIcTnf41dVu6m386zskufrG35hOl0ZpSuKE+MvltsEw7yLe1NqZmFr4IHEggO1nvA
	TuZghjCitof8tUYdPxlJcMJnvDtQ//0Jh6ZHv/RXewaiIwMQ4XBWrKzUAW7rhGTcgHc4vgS2tOi
	7jHDamlMyyIL2qJoqQAxS//hLUakvOfSVo5M/BhOfkzz35Ri7TIrI6EeVs2b2Hd8dbyiouu+F1R
	eZj98PRA+GG4nAY96P/j7m1X0bDfR10Ckkw==
X-Google-Smtp-Source: AGHT+IGgpsMa58ODg7KKsYPe7knbh5aVk4ORwLNiUbqV8cXt1dmaSjam+ARmTn82BKRl7ZezWl8JVQ==
X-Received: by 2002:a05:6a00:66cd:b0:772:33e1:1d8a with SMTP id d2e1a72fcca58-7741bdf5ad5mr24054025b3a.0.1757502716887;
        Wed, 10 Sep 2025 04:11:56 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77466123e13sm4720578b3a.28.2025.09.10.04.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 04:11:56 -0700 (PDT)
Message-ID: <a7c600ed-7caa-47fa-b735-8f569442f1c8@gmail.com>
Date: Wed, 10 Sep 2025 18:11:51 +0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Documentation: cgroup-v2: Replace manual table of
 contents with contents:: directive
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux cgroups <cgroups@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrea Righi <arighi@nvidia.com>, Johannes Bechberger
 <me@mostlynerdless.de>, Changwoo Min <changwoo@igalia.com>,
 Shashank Balaji <shashank.mahadasyam@sony.com>,
 Ingo Molnar <mingo@kernel.org>, Jake Rice <jake@jakerice.dev>,
 Cengiz Can <cengiz@kernel.wtf>
References: <20250910072334.30688-1-bagasdotme@gmail.com>
 <20250910072334.30688-3-bagasdotme@gmail.com>
 <6geggl3iu2hffdop43rtd6yp2ivd26ytfn4xdclurwce6mapal@4ve46y652dbj>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <6geggl3iu2hffdop43rtd6yp2ivd26ytfn4xdclurwce6mapal@4ve46y652dbj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/10/25 15:13, Michal Koutný wrote:
> On Wed, Sep 10, 2025 at 02:23:34PM +0700, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>> manually-arranged table of contents (as reST comments) gets out-of-sync
>> with actual toctree as not all of these are added to it.
> 
> Is this true? I generated HTML with this patch and the resulting ToC
> matches what's in the comment.
> 

I see some sections are missing instead when compared to auto-generated
toctree.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

