Return-Path: <cgroups+bounces-13905-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNM4MhcOjmmS+wAAu9opvQ
	(envelope-from <cgroups+bounces-13905-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 18:29:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF71012FEC2
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 18:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F5103022C06
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 17:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2780A258CD9;
	Thu, 12 Feb 2026 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzujQ1Ry"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DF0260569
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917390; cv=pass; b=Vqi1D8eMFq7E6CYCVFrORgNhz6d6fsiYNT2bnJtBfj+AULUXpDm668rItgZSsnGVUJ/Vk8/oHuiDK5f1cbY+mZUMjImPmQCQ4J3xCYrAYlbvNv85HgykB4uE7n6CPQX4XjVKvETdyOsyrBeulftN9KXHWf6D2AClavPkfNLIGIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917390; c=relaxed/simple;
	bh=DyST9RsDa8+RJbGkxLnNeDzfcMCn5YRH5YsSqjoA3lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o23RVolSeLlShRu7LXl6Va1XKI16ZPYJd3vU8XJJ2zQWcNtJRNsbEYC1DMsHB95mErUKAOzyrFb2/zNh7v7MIm4G4dYO4OGNF+RBF3EnXX8S0bAYoxXQiQBgTZFdRvHUqpjDLU/cwkS3ljFpmrNwmxcE5iveyww82Kb/mrHBxbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzujQ1Ry; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so738255e9.2
        for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 09:29:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770917387; cv=none;
        d=google.com; s=arc-20240605;
        b=TRLpaZEatYcVScU2hae25pVmkgNR1UXOcZkrOTrB4qEXLy7FpKseOxw9/dElQzJb31
         NFUJoSnGWo1fcAFwAzWqfpcrhS3ghrrprAzNB0HPzSr8myJV9bx/QK5qWvpo2Z8K/HL8
         Y6+WZLPwlbeNVBQ11g5p9fl65qYIUS2rCK2IBlkmNU2LAwKzlRgHq20y6+GRgBsdOhhq
         HLFDP8QCBrD5REnGEI3Gqfj3KPbj0FNFK1VkLGEPuB5jHMs5yaHludQ4+yzyeTQeuHA4
         GnKdek21TBPjeGcCeyggmaVVVMXXvyBfgQ3fFBV6/aevsOBM+qz2bPY5vLTArCJftgag
         j74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DyST9RsDa8+RJbGkxLnNeDzfcMCn5YRH5YsSqjoA3lM=;
        fh=dcq6eTZp6R/s5sRLOB3Hwe7+jzvC0lzXiNXbN9/4Xrg=;
        b=BbdRWeMjUdcK3pFaDXGNislrp2iP06G7qBtFkOp92O2qVBtML1DuXPNZB1Fgs+1dyA
         RgNh8kuUURpOGHqR9+yVI4+pvXZKsxOu+pKvEQsLTd2ikT4sg1QktD1DhmQaWcveRJCI
         QW4tfQarEOCaa3jlm1N1cgQ4DHdcZYdbtY0R4vOpu9aqGE8dTy+BdoJMda+RGUi5TUnP
         1pirg2hAn+6zFH6v8somBj0oclBxZIwkllcP0TIfxGIvQfTGmfzvvz6T/ftB0cJjtCmb
         6U87Lm+f9QGqlaf3nFRa1mjvenAJeV5zXfaMix7A2AY7hSc4CNJ1Rd5zTXKuGJCA5dCU
         h1BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770917387; x=1771522187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyST9RsDa8+RJbGkxLnNeDzfcMCn5YRH5YsSqjoA3lM=;
        b=hzujQ1RydnP441MhMRrN1oTiYkqld0DU28XoyxkeDPloV3vISRyvDdWHCbSO3/1NSg
         koqOyM9YM7eLE+gc5NNw7cWOYqRQ51UJa+7jdrhVqh4bUkTMaSMHCc3WImZoAfXBE62L
         zU5IuqibJWILZg1gk5OeycKNRUrz7a6d5OD2RFycYP7e0ZX1voatYfQzSAkb37x65uHA
         qwR81+/8G71OMRjKbatmVzXY9AH+ISOlW1vdFxTEwC2lr3dhSQPbKw32mjrhrUiX18Ij
         LoFm9ET3L6sqE+B/zvCRGfvbIkkd78Hdky9nz2LXmIXJK1S55x51fmFYBKVgjgw/Vv35
         sCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770917387; x=1771522187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DyST9RsDa8+RJbGkxLnNeDzfcMCn5YRH5YsSqjoA3lM=;
        b=qOYbEeF/rVNgmpqNCLLSnvPTfT3vhNFxDIcTqwW1Iswv7/jdRMHgbBdA4jYqZkYOk3
         C2mfQ4GHZQA3y7Lsx1LEnBlk2v1C5JnIn3q4jvAbDAt5Lmwi5aRw6xcsB+sCZX00aOSD
         KYiwR8FS5FccE5pH7ZMBfs+eR0Z4qtxi2NKQSjcHtXy/GzH0zlSesnFdF31+8l66J1W2
         T69cTWY0zmHHIecup2SIT47b/nVYP3VyQ1zloffSoSnv3msML7uTDPq0qdtubDOgW1Tz
         eP4GhSgcM0alBzqh+luLIYC9DdTN+iPFwY41/wvM5ABN966Ue2gTHaoZfCIuhLHyDHcK
         c3WA==
X-Forwarded-Encrypted: i=1; AJvYcCUPieSdDVRcuD24xXmX+/zJcq++SNDNhGnpkXDOYKVP9I8+knZKeuLHafRgtRNxo0BCJD0Ys7KM@vger.kernel.org
X-Gm-Message-State: AOJu0YzGCk3Ag63Zb+as+G3WXik6ZfFVb4bdO5+pEGUkuEWhC7EySqR3
	tYuyaF/N81bnwXGMCzPw/Z7CnGZhxssYhkZWK4V6+Fm6F5HaOLDUifd5NK0sli2szRJEChVhsNZ
	g8UxCn92OYcLsTl/MYl1KIRiooCIeMWE=
X-Gm-Gg: AZuq6aI45IPm7T00WuQhMmQih+lotxxq8qpnj5RS4bsAToFK2yb6tS8cwjj4ktSQLYI
	XPFpJrw7wjRFwfVZ8YqK8OqNHcz7O0VB08E/Q2+PHLhC4dUwO44+HPBJkvghQeP4kbwyyODFS2u
	eIJjuJxZvIe4HDEM72B34XpsfORKrXspGrp6jwWQWzsP9vXTjCxGe2nhZI1RZCgY5z2CnRsNgT7
	5CrfktXHpEF+zTmq9KRIIIpqeGiVdNiF8zCuQTeRXYI0QR306BfrE6YFOEXbLxO7cSo8LV+U1iX
	EYDMHxm0J0N/uEQA2Pm2DNmVTSZ16A75/oDQBTs=
X-Received: by 2002:a05:600c:a010:b0:483:709e:f227 with SMTP id
 5b1f17b1804b1-483709ef2c0mr717625e9.31.1770917387264; Thu, 12 Feb 2026
 09:29:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208215839.87595-1-nphamcs@gmail.com> <CAKEwX=OvuVPJzQsSQm8F+zsRgJFnbMmW2JMJbGebp=U8+jMRYA@mail.gmail.com>
 <13e3cada-60a3-4451-ab7e-16dfbab3c352@kernel.org>
In-Reply-To: <13e3cada-60a3-4451-ab7e-16dfbab3c352@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 12 Feb 2026 09:29:36 -0800
X-Gm-Features: AZwV_QhhzDWUucMWctDXYEld-DEFpbH6uyQvlM9NhhkkV4HCEsfeHDqKgPzh2sk
Message-ID: <CAKEwX=Pww3ZNw=VGZBa46NhKuvefRM7wnVuZy0aADoCoE1KSzA@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	hughd@google.com, yosry.ahmed@linux.dev, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	len.brown@intel.com, chengming.zhou@linux.dev, kasong@tencent.com, 
	chrisl@kernel.org, huang.ying.caritas@gmail.com, ryan.roberts@arm.com, 
	shikemeng@huaweicloud.com, viro@zeniv.linux.org.uk, baohua@kernel.org, 
	bhe@redhat.com, osalvador@suse.de, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org, peterx@redhat.com, riel@surriel.com, 
	joshua.hahnjy@gmail.com, npache@redhat.com, gourry@gourry.net, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	rafael@kernel.org, jannh@google.com, pfalcato@suse.de, 
	zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13905-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[get_maintainers.pl:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DF71012FEC2
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 4:23=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>>
> Are you CCing all maintainers that get_maintainers.pl suggests you to cc?
>
> --
> Cheers,
>
> David

I hope so... did I miss someone? If so, my apologies - I manually add
them one at a time to be completely honest. The list is huge...

I'll probably use a script to convert that huge output next time into "--cc=
".

(Or are you suggesting I should not send it out to everyone? I can try
to trim the list, but tbh it touches areas that I'm not familiar with,
so I figure I should just cc everyone).

