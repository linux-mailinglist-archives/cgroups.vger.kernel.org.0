Return-Path: <cgroups+bounces-8440-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B5CACEE64
	for <lists+cgroups@lfdr.de>; Thu,  5 Jun 2025 13:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C30F189A8FE
	for <lists+cgroups@lfdr.de>; Thu,  5 Jun 2025 11:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A6D2A1AA;
	Thu,  5 Jun 2025 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QGNPjAf6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A8129A2
	for <cgroups@vger.kernel.org>; Thu,  5 Jun 2025 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749122283; cv=none; b=WiYW1t77WuyA0nECXervxgBitlzdIoP/6uStcV5ILYFo1s7H7ZX7t4arfi/CS0Dua4kSaSl8L/gFxAiF0ZRWJHIvE5ehulmtIlSCnoi/JxEbfDf3U+7ZLhzq0fKuGkSKCSIvSz2UMp3TD0eC8A4EcAcN8TUCHkf28Nx/3rX/uK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749122283; c=relaxed/simple;
	bh=DiLFgGEYWV08VMwsx3D3eD3Qjk9lBihrYpCcp2CM0Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7l3n1NGkQk6lEqjHLdK5zawuo1W2zcrUL5nRaQ7TXWQsFd81rMstm8BabfADq4aPc3gGdf1rhvVvwJkCW6BlgAHix/2qshBEQPSILkhrmvZdZfnu+EOQ+fwIhr2XMaJpAnldFiln3xlqIbprdwJe3w7o0YVlce3mGu5nexZXlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QGNPjAf6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so742275f8f.1
        for <cgroups@vger.kernel.org>; Thu, 05 Jun 2025 04:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749122279; x=1749727079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DiLFgGEYWV08VMwsx3D3eD3Qjk9lBihrYpCcp2CM0Zg=;
        b=QGNPjAf6WXu2FahnaDYkrkC6XPqsnHRO3Gl6SghpMrarq/9VNneATyhp3hcHilErII
         PjK/tk3ZJ5qK4FJYstZZKk638D3Zyhl7Cn1mf1UOr8vsdJY2PfLXsXTqI1Y1YBrTnLSR
         0VKECEc5ee4LkJLAcJMipvq65azbxaa+q4U8BnqA0xkPnQaI6i0Z9VEpEnCXdRf3amwr
         17npdHqYDNi3aOjObb2zEyOgNWa+q/pc2YQfhx3sAdmMaaARUDSqtO1+/ojQAmm0Y9/h
         653Ke08LOo+blnXcKUmNKyEQ2XO9Ed3ysDK0ola+Du82YYMtf+W0HfjoKSwH4pFLYAKb
         KNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749122279; x=1749727079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DiLFgGEYWV08VMwsx3D3eD3Qjk9lBihrYpCcp2CM0Zg=;
        b=NGcg3qDV9FbcJkdG2LgthJmJsifjwBJTGmg7xqahhFICfJ4fwDSuj5ItR6EwvjEWC+
         NQ9RYZfAtNn3EDzFDlf2XFljk6fcPFlUSUpklCgk7c4AI84+RrLuJtVA00Smz4WkCFPn
         VNZHSP9DdxlK+7trG6zrqKGUGaNu0Hcn7A29roxXFCgTDKfjSenq4PVbLt3tVf4ksona
         XFdQ3j5oDyV2dpiGUVtZnaXKDWDCFivD0fMEFyxDuOFUDtJS4sEbiFaUFNFmt8CQiy1X
         EmmVshrIU9IWvTrp2j6DTXDko5Z7SFfS7lvXaeeRR0ItcHYxSjBeHSXuORJblGdvrpXB
         O0yg==
X-Gm-Message-State: AOJu0Yzbw2hva6B4QCGWEHB+TrzsTw0E0J+JBiUZG12tTGr2B8uxENOX
	/KT/FpaHCoY7lUDb4duzmpp6m/gGREtcaAnuExjrZ38LWZ+ZB8zGCjDz+KVgUU57aiE=
X-Gm-Gg: ASbGnct8OmvEdCHDmTmIJbx5EE46BM2LBocDfWIy4Mab2KDhWPSM2km7T1t8fd1Ryn2
	6mYViOhsQlC+64iVsMkqAKn/0lSOwKFtlR1GB+BPjRlR4JyaIVOs8CLoZNIpHGGM8Xl7kjpXGP5
	wJILpa44rzn3IGXjpOOhtZIMa42DMUFikw93fM0rzWR0BWpqG9kW7PMem6wyYkepGgblbZmU7Po
	Q9/oCe7lbWb5VUqTEPKRNlmqV8nvGYfU225t/zJgKZu8gqRl2vTOwmM4f+IoBGjJAtQpa5Etpqo
	RvMoCAIcVM4zrx2oW4zyLQ0mLQFjYx8VVxtT8YYxnMSTwLXWbJekCxluCXBCS3GnOoLAXbhqurY
	AJDbh9VeDbkE3vpLQlRFjB3fm6XU3rBS6daDO+qYzr7zdutWmS7FH6Wb0Uh8QBMffst9Yc8IAal
	DmCb+UZOI7eCWHjA==
X-Google-Smtp-Source: AGHT+IFP1EjV4E9gaT07wfw0ERePJcrU7wPEYwd/wMsMGvhyJUh1OuBGGMFWyOWpV1cSM0QSIQVL9Q==
X-Received: by 2002:a05:6000:18ae:b0:3a4:d953:74a1 with SMTP id ffacd0b85a97d-3a51d92f7e1mr5369163f8f.23.1749122279156;
        Thu, 05 Jun 2025 04:17:59 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f18:9700:bff9:d9af:e929:c0c4? (p200300ef2f189700bff9d9afe929c0c4.dip0.t-ipconnect.de. [2003:ef:2f18:9700:bff9:d9af:e929:c0c4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd93f7sm117204765ad.95.2025.06.05.04.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 04:17:58 -0700 (PDT)
Message-ID: <b15fa0cb-e893-4642-9aa0-05f732b75131@suse.com>
Date: Thu, 5 Jun 2025 13:17:52 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LTP] [PATCH v1] sched_rr_get_interval01.c: Put test process into
 absolute root cgroup (0::/)
To: Petr Vorel <pvorel@suse.cz>, Wei Gao <wegao@suse.com>
Cc: cgroups@vger.kernel.org, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, ltp@lists.linux.it
References: <20250605142943.229010-1-wegao@suse.com>
 <20250605094019.GA1206250@pevik>
Content-Language: en-US
From: Andrea Cervesato <andrea.cervesato@suse.com>
In-Reply-To: <20250605094019.GA1206250@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Merged, thanks.

- Andrea


