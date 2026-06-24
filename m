Return-Path: <cgroups+bounces-17230-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id izFROPzQO2qedggAu9opvQ
	(envelope-from <cgroups+bounces-17230-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 14:43:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4BB6BE3AD
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 14:43:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.s=20251104 header.b=NdQ49Otm;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17230-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17230-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCC34300A3A8
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 12:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7BA30E0D5;
	Wed, 24 Jun 2026 12:43:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49B62D780C
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 12:43:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305007; cv=none; b=ZqItA8I96AeebZAFKx/6WwhS20YaNrxOmQLBkLsYSjSq5gqSuJqk5r5szkh1d46gcPc+SFGuYpm5SjoozvTQ65xE623VXv89Q+oGboY+UmeXmblJ9nIfTIgCBxIucU0sCTCmFbl8i/6iQ7tI7mg77aoNIWusnSwgIPaqyPnMFrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305007; c=relaxed/simple;
	bh=1wS2Dp0j8j7U51hcsEcED+6qZEgOqRZvoSwj5zOBI+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qspm4NAlpRQvbSgDEYFYwlzC3gjHEwkMPNFeAPkmLr7/r9wCEqrFrzASgsXyTZ2wK2baWJGB+VofB9zyVJo1GeEeB+WIw8slGy1P6e/TxsOzjyl3C27sliFDSUFCp33I5sGZR+fqmoZSBbJ4ggdjYG/ijAczZSssBZ50JnKKuQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=NdQ49Otm; arc=none smtp.client-ip=209.85.161.54
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-69ec2ebec61so622797eaf.3
        for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 05:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782305005; x=1782909805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3vBqNWysPNQvqkzsE4GQXCpY5+Q5GT/QhxmkZJrUXw8=;
        b=NdQ49OtmMM6pTd932PgSzQLVlQLQia8eFx+1H4eJV+FY5ycGnb4e391PH51FCCO9nH
         tXdBfux67ra5F0bf5duaGfi6R6UDw8/cA5JFdDfuu5mbFvkB+TT+TaVUx95lCYEKBfNt
         yPpioPJ/yNsEWOpZd31galaxrw9F+dlq76DnZIP1WCl21JUVPiG87mzpC0VioHrA18Nc
         /tHqbEPoYT8jGENF/wGUf3RicpBZzGbo3/WZyhHqp8w42gKMqqN9/VCuShmYARsU7G0X
         /KZat0YH00vALmDihnkwflZLb8iPcu1NlJu/G99LUKCH3+VH4TdRtUCLSlojvS1jGlkW
         /Cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782305005; x=1782909805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vBqNWysPNQvqkzsE4GQXCpY5+Q5GT/QhxmkZJrUXw8=;
        b=Bct5u4w0vbB+dEsGIvl5u7uN5CZQ4PolMSg7EPX7GoYRrWOK4ZsHCePCaAtbGKpLQ/
         33zyQJa6PEWkxxXElCrtilB4s2lJ1cko9ssorDmhlRYXNtYB5Ql0MgBnyKlQpHY76iEf
         4oUhK37PTnpg6RvPUrJDpGS907M4dImoaTTaszNW1qwHiRnZxNY8htTIL3HbrfdD9cCW
         VNHqrgXCCY4bt4VMNAgkxTC1Fv9x/od4GBDccYxkj2JyQpAYpFl7JYd1/WFl837cmcE8
         nDpt3Y797lRiQE57pp3GtD5noNsKSybYohOhDo+JhWXqq836V7gHg905IRZ2ODr7+yOP
         d6ww==
X-Forwarded-Encrypted: i=1; AFNElJ/JXBkkzzfpIl4Cp7Ho73wjAG0pH44dh6fmqIEnn80JdJHc2+skoHHrlgr9NvdRxqH7OlkioLbX@vger.kernel.org
X-Gm-Message-State: AOJu0YwCck3yMSXyjlegSZD3pBbTIIqlJvJ1aXOQCad05hdxku7OA37d
	/+GbE5Lgksfd96MTkz8eNc9+t2EldII3LNJUafWy4z7HOlHie+iva/nwGBx0DO26D0I=
X-Gm-Gg: AfdE7clsdmAYV56waiIIMaEukNC5+uql+wPJC+OG4IIjpT1e5E57Lj5+TL+JR9ZBbIA
	OiB+S0IVLHcV/OdX2ERFGYMvSuFSF/pboGQmNUejfGuq+LXuQhsYuKh6iXxW723K9eNYec0k+A8
	dfqQ66867/DH/Erh7I90F8t1x5ETRy5PjtBidq0l0chuNbeLKUKB6ka8RGMySl7/OE5t1cvYGPL
	fmQMJiA2gArEtSASPklazsaaRCWbYs3sm3PvQsiikC43hjH1SflwrGrXcrwQJDrwwk66gEhkoaZ
	PpjljHlORSSNjjQZ3hfe28q4Gru4NnRAAVrDjORVKyyv/iBnLsSImFhlcdV4Tpz/JR7thGjksvz
	fIjNwEnVmPpppu/Bw+pAcCKz9bthDNI5Svwq2yO1xPW9XYf1Vq/cUiSo81RDHLxHSoPy8eHyxCs
	ORSl/WhOPOtfI2HDA6nktuklN1PvNq7uIiTyyPudJLtuzPFrhEbx2nsSHTxwjUcV/0J1d35u0=
X-Received: by 2002:a05:6820:2110:b0:6a1:20d6:ccd9 with SMTP id 006d021491bc7-6a123020da0mr1995384eaf.49.1782305004833;
        Wed, 24 Jun 2026 05:43:24 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f0464a6sm10164438fac.15.2026.06.24.05.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 05:43:24 -0700 (PDT)
Message-ID: <34d48fb5-4952-4a48-b92a-f189bc3edd0b@kernel.dk>
Date: Wed, 24 Jun 2026 06:43:22 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] blk-cgroup: remove queue_lock nesting from blkcg
 paths
To: yukuai@fygo.io, Yu Kuai <yukuai@kernel.org>, nilay@linux.ibm.com,
 tom.leiming@gmail.com, bvanassche@acm.org, tj@kernel.org,
 josef@toxicpanda.com
Cc: akpm@linux-foundation.org, chrisl@kernel.org, kasong@tencent.com,
 shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
 baohua@kernel.org, youngjun.park@lge.com, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1780621988.git.yukuai@fygo.io>
 <1c739fcc-5132-4cb2-bf34-cec94de26509@fygo.io>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1c739fcc-5132-4cb2-bf34-cec94de26509@fygo.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17230-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yukuai@fygo.io,m:yukuai@kernel.org,m:nilay@linux.ibm.com,m:tom.leiming@gmail.com,m:bvanassche@acm.org,m:tj@kernel.org,m:josef@toxicpanda.com,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:baohua@kernel.org,m:youngjun.park@lge.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:tomleiming@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[fygo.io,kernel.org,linux.ibm.com,gmail.com,acm.org,toxicpanda.com];
	FORGED_SENDER(0.00)[axboe@kernel.dk,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	DMARC_NA(0.00)[kernel.dk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kernel-dk.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A4BB6BE3AD

On 6/24/26 12:57 AM, yu kuai wrote:
> Friendly ping ...
> 
> This set can still be applied cleanly for block-7.2 branch.

Not sure how you checked that, because patch 3 very much needs some
manual attention to get applied. I have applied it now.

-- 
Jens Axboe


