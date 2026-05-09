Return-Path: <cgroups+bounces-15689-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5EbKDTUA/2lP1AAAu9opvQ
	(envelope-from <cgroups+bounces-15689-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 11:36:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD854FF010
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 11:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3A3E301626B
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2026 09:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ABB3988E2;
	Sat,  9 May 2026 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC5UVEaE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608083921FB
	for <cgroups@vger.kernel.org>; Sat,  9 May 2026 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778319407; cv=none; b=KSmTmoAnGcqTEFZUXpaxMKg2mgAO2+8XIxOxzueq7IE1VeSfhRmjJOIBicb6mm/7b0y8x5dtia3c4qdxUBF3rhzkHW4g1KUhpGSvZaob6vJ2YI1AjwDbo4he/XphAX4lnId5QTMi6ZvPmi3kJ26ZgvtJiwEEZEKlqTnBVPDFwGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778319407; c=relaxed/simple;
	bh=yiQpGL0pkorcVnklu6I4G+NbYMzQb5W0oastiLX2lIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pk4kIpcReQS22Y4vBljm95SlSEq6hv+9R1YBkQzq/2Ri8QXY1ulKrkRT0MXuBAOAYXR6r4b+cwKx08xUx8m96dtsAcTjWtUY5aHDU9vH77bD2hxHGmZsJwVawDuXQjdzYlfQw2Ut2R2Be0D1JuX8jhkmSsSWg0dKaGRqKgw6JbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NC5UVEaE; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2ba4efedbeaso20271865ad.1
        for <cgroups@vger.kernel.org>; Sat, 09 May 2026 02:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778319406; x=1778924206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yiQpGL0pkorcVnklu6I4G+NbYMzQb5W0oastiLX2lIU=;
        b=NC5UVEaECLocshQ1xeSuchX3hRmLi+LHbPDvV3aIINWmTm8WDVjEWhjcB8fzEOSpVz
         onl8de4GQiuEM5cgDUC5BfbT8TOGt4dHwKhHlKu+AZ6xMPwhyGXOOffe7pnUx9pOrkRC
         pBceTrgmIVpCwgJmSbQqHX0oLj3EvKJYK2qduSvKHrTCmhZbzcVNsrD/gjKyfnBv9yEp
         3HWgbBmQSzd9Uk2wSPwEPDwv0F/yBxFvyELufSehKynkM7L2KbYckgR7lGgPrWaAZUbP
         6mQyrqMu7jZvHD9kShvEmyQdHr74a1tvceugyRyldVXEI6AtwjnIzGb8BBF7a7p6Ud9V
         +S/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778319406; x=1778924206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiQpGL0pkorcVnklu6I4G+NbYMzQb5W0oastiLX2lIU=;
        b=gOfGaFlicJypmiA2TasQNPvh/AYKdHf0ab0lE3XqiXmVHi5RhqPYMENKH+LPXw+9Oa
         PyuMH8WKZTrbPwX4k4lbx1wy94Jqy6d07CsXyLwNQToKpxVmqMxPGkUDItDbBF3/Mbku
         IqlrOw9t4vwkkPU85R3W3OIXOm4sxLBfsfSAV3CC2xu3pMdpkYID79GAHBCJbDKyfccK
         UcXrgCEunA0FcEvvYtbYOhzv+Ubr3jCvD9CvIYMGTh3DE43GDixaZKxXp8nienswWpmM
         iJxreo5oUronhwXL47JEksPy81p/RMZMtwV2R2K6/0BMdw0F5RPphA/cXkgY93zgyG9L
         61xA==
X-Forwarded-Encrypted: i=1; AFNElJ/4IFqu42GQi/5jsiaRQmHb2SVAyyCWTvjQAr7Ddh8KmqA7z94VtvwQZloYDR159Barce9zpFUj@vger.kernel.org
X-Gm-Message-State: AOJu0YxsnjegHyPf/LYlsgA8aiX8OSKwagInRYq3sEbns3hKZoYsaybg
	ZRXZKDA9tbk+fft9gy49p2lRNRo10QsRxkFjQDmZCeHwUCv5H29WYAU8
X-Gm-Gg: Acq92OHDeZGrihAueJmWjZeDaARgLCqzrCqSbYcgtk89sQJs+hHtPnnRURNmKixgYmG
	cLra538f6NGHpB1gA8N0Q9YuKGNf8c/okf8pFm/8+JCumHkrPUF6kyd2ERTNw25vCIXPLL50YiH
	qHR0ki3h+wz4rGF9JiZK8bs2qqQlAA5kURw3EZ19MpqEOQiJ82O8uZEThCHoBHZ7phJg2Y6c36C
	Am+4cOzUfMACggKAfl9XjkoD67Aqgfb4ojEdfwOoVSHlsxhsMmGmjLDI7xIFBPSnll1awscyPyl
	FnnRbi2MdQ3pqcIdAnF7NLSnsCvpmEbCXtBk6dsN69E9ILvR1yiDqSvYn6wuHFAB1P5zFplnzVO
	z2JkbOLTIc9OJ+wb1ny4y3Ad1+dXzAuTsC7KAQLnqoqAgSJ1X/SYYXbaVigS8ZQ0N7ZZwrAfZIZ
	++/47cN5DcdWrkXKzaa3FS4i6UfnD9lyY=
X-Received: by 2002:a17:903:2bcb:b0:2ba:924b:3948 with SMTP id d9443c01a7336-2ba924b3b5bmr154695975ad.15.1778319405563;
        Sat, 09 May 2026 02:36:45 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d3ffa0sm47361875ad.25.2026.05.09.02.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 02:36:45 -0700 (PDT)
Message-ID: <92eebc24-9612-4ea3-9bd3-da4d437b4d81@gmail.com>
Date: Sat, 9 May 2026 17:36:39 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: skip hardwall ancestor scan in v2 mode in
 cpuset_current_node_allowed()
To: Tejun Heo <tj@kernel.org>
Cc: longman@redhat.com, chenridong@huaweicloud.com, hannes@cmpxchg.org,
 mkoutny@suse.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260508062940.4094652-1-chenwandun@lixiang.com>
 <202d0aa0f8da75986a895ffbd564b78d@kernel.org>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <202d0aa0f8da75986a895ffbd564b78d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9AD854FF010
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-15689-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenwandun1@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 5/8/26 23:51, Tejun Heo wrote:
> Hello,
>
> is_in_v2_mode() is also true for v1 mounted with cpuset_v2_mode, where
> cpuset.mem_exclusive / cpuset.mem_hardwall are still settable. Would
> that be a problem here? cpuset_v2() looks like a tighter fit.
You're right, it is a problem.

Under v1 + cpuset_v2_mode, CS_MEM_HARDWALL/CS_MEM_EXCLUSIVE can be set
on non-root cpuset cgroup, so can't directly return true;

I will fix it in v2.

Best regards,
Wandun
>
> Thanks.
>
> --
> tejun


