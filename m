Return-Path: <cgroups+bounces-16490-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FbpEnkrHGpwKwkAu9opvQ
	(envelope-from <cgroups+bounces-16490-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 14:37:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E45416161AA
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 14:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AB6E3004906
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D28437DEA9;
	Sun, 31 May 2026 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="H91FdTyO"
X-Original-To: cgroups@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503723783B4;
	Sun, 31 May 2026 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780231030; cv=none; b=cmRYhK5LP3qdeIwX0/v1bcVwDQ+d4uIwyWv3PVyVdjzZqHOrYWMIl5ea9Df1R6+qhwgNhmlquMpwYlMimjqlG9HdMCc5iGt+FFb19XD8GGH0UGT0uPib/cvvz54Mt8eFARVJGwxLa1besHOeTaTGgHTdNy4qENsBhb7UT27AuZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780231030; c=relaxed/simple;
	bh=6GFEQOnqt7UcN9zu/fzXfxBvTaMcQB4DqFXj4kqVO70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o81EtkqU9Di/27z7SPdM8C7egpI5Fh1r0cQzSDlUGxkhu4q+TPYLmjsdzCQsOT5lslkKQGa+1UwkoVwTWJx2YMq/y8EHJIVmEnyZ4aFyk2HM2UcAxg0omdRy6dUuwjQckxmPz3Ovp4U302w7iV6Rwkru1Lo2BNdmDNIJxCnHA2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=H91FdTyO; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780231023; bh=HL+wohryqOhpKGEyagy/lOHeWmop01YnUKtre6cBpa4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=H91FdTyONTHJgIAbaZiumO3bQt+mOJZmCIzauEVd5mnirUtqBTKKHNXeW26psSaJL
	 a8d1GiBOLRz2pjLT5IvZtGDKE7TpUHI9bQkqSjHdeMEKlvCmt71RwrNoKQTXku/39g
	 P+cDSWA8xMvkZnmEnvjv5fIxJD+ZhSIh0I80a938=
Received: from [10.24.9.42] ([123.112.11.230])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 88587460; Sun, 31 May 2026 20:34:05 +0800
X-QQ-mid: xmsmtpt1780230845t6jodq04y
Message-ID: <tencent_859FD9151DE6F13D2447C86ECA2CEAB9D809@qq.com>
X-QQ-XMAILINFO: MpYZqmNm/7vMmnst/jX7M/5lIu0zok5pcX9bgbd/L55BNRONuZnTr8CFF7x+hi
	 Lm8Pc6o+SnwpYTDFwgAUG3KGyLgs07kCNt3JeGgJh8HSSm2htgO5UwIEfhD9/OpmrqcvfI6YwpHH
	 yS8sSrdIok2pzZhn2eGrHuNTbqhFaDKm+XHadLsKV8KoXE4cZqfiaPEnQXIGoRDTuu/OfjdQI7eR
	 iCz6VW92AA25Rq6zpg7e5E50Ip7qtcRrak/13rWOG90s2I73dK2KTJ/LdDV6avtMfVzEdlSpf6Lq
	 Vb/KbDAVuggLvjLkCucUWzTL1GeE4wbkcnOQCpoxlL3bfYJWynDftEwQ9iPkJQe18bfCNLSO9U0D
	 8uCyyfay/mOr1ms3Giv7DNGyRag8dehwGeci7erd+R4tJpMWrAtgCvp7V/z56Fvp5ML18vwKulc5
	 7+isBuSeeNmymq4jzMdJm4WNUFh05jyKXNNL3c3c3cxE21vn6Jvq3vJ1dK1TKivm/l7D7zpS5jmk
	 +iXN0FfFlWP1HBts7x43JyjgKR3XHodb4MFTRDGttRpK0tkJV7tVz26lOwdbAtAF74Oelm//ObEd
	 GsBOI70by6vm+WZlqnD14CnlfWGn8/Klc+2F+H4VqCPFErxDR9/YUvGd9Mfw/AgRS0LT41bnosnh
	 JDW5f29TY70mAqdP/933Gbaxyny0dwDyKZQg0k12lGmvUEqtn+3pgyYRSQiC/pqAkA4OmISl/Xrs
	 0BKnbWpxQRUVU5WcCWZkY4ikC4J/bkNCkUXpZcVYm20PEXdcTkYr70LMo1hGoDImVA8ag+znDSHF
	 3Br2z2IwOVHpCJIFKMAWrPSlGpTdjnDw9YVocGAHgx5n4xRE6/0dumHk7O4j+wfkDiwtqhi+KBJs
	 BZuw7XZ6Y1Ei0kFPhti54DHQcxFNH6zwvsTXTckqQCnDyn2F95w5YeoLuFBdAy9QQrq3MJHcn+HL
	 U0fMaFsTEoMfpFOg5P4zdWtUw9DfNQmQBJrViqtqSfjzw49QsJ54CKUILaO8t7kUb3RMyqHZXJAM
	 gpM2KTJy7zj+FTDA/NwvqnQZ5qWUaXKNbjgt6noLGLo/gje1MiwKGsifBCBnRPY1QbNstzt9BIYn
	 Cux1llYlj7+C4jvq/vkTJbL+FNy3TliHAvzriFrBY4YeghhB04c5T1bBPxpw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-OQ-MSGID: <fe224381-fda2-4d7f-abed-49387fc9872b@qq.com>
Date: Sun, 31 May 2026 20:34:05 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/9] mm: admit large swapin by backend range in
 swapin_sync()
To: Kairui Song <ryncsn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Alexandre Ghiti <alexghiti@meta.com>, Usama Arif <usamaarif642@gmail.com>,
 Chris Li <chrisl@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Yosry Ahmed <yosry@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
 David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
References: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com>
 <tencent_EB78848E34DC7858C873193D67286ECD4B0A@qq.com>
 <CAMgjq7AA_1esgtA8VyxaBLWBBRM12bCBpxO2Jch5OESBZSg--A@mail.gmail.com>
 <CAMgjq7AQwF6oNpnGTxxJWb=oyZ3dLfPL4oSNoS+eQxtuzZPgTQ@mail.gmail.com>
From: Fujunjie <fujunjie1@qq.com>
In-Reply-To: <CAMgjq7AQwF6oNpnGTxxJWb=oyZ3dLfPL4oSNoS+eQxtuzZPgTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16490-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_MUA_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fujunjie1@qq.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,kvack.org,meta.com,gmail.com,kernel.org,cmpxchg.org,google.com,linux.dev,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DKIM_TRACE(0.00)[qq.com:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E45416161AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/29/2026 10:45 PM, Kairui Song wrote:
> On Fri, May 29, 2026 at 10:43 PM Kairui Song <ryncsn@gmail.com> wrote:
>>
>> Hi Fujunjie,
>>
>> Thanks for the update, but this whole defer_memcg1_swapin thing is so
>> ugly I don't think this is the right way at all.
>>
>> If you really need this, maybe you can always defer the memcg1
> 
> Oh and I'm not saying I'm against this series or the idea, I'm just
> saying this particular design of this one patch needs some improvement
> :)

Thanks for your review! I will improve the implementation.


