Return-Path: <cgroups+bounces-16154-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDHgD1rsDmqwDAYAu9opvQ
	(envelope-from <cgroups+bounces-16154-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 13:28:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 455035A404D
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 13:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D00030080B5
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 11:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996963AC0D4;
	Thu, 21 May 2026 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osXcrfhA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204FE332907
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779362900; cv=none; b=W7noR5i2fZ+f2bUugKZyH1VwljLXc9MChkSs97vzWOrNDGF9vtvcuTlxnH23QY+Z5GfukbIWEzPSOo3Ts0JMKj4FVBDRRPioy2lTIY5U3ERzbmiaQkMHja2JP00XJLaSOVJAis7cb9Cubheaqwd2XCA6BKKVkhWWLQw8lAobBkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779362900; c=relaxed/simple;
	bh=/AMVM3vBzoFTnaZzN+zWcS7iQx9aqetmnCsN4HD66PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UX8OZNjNXdcNC4Vrsu+mykRCxKnN71KHxq4X2EhdJsb/7HXKAjUDJoSI/lIMYbZHbEn0VQvIu8J8u9qOOcMApmdRWM1WnBRsiiuv9EoCilyHXb/bvQIMe9TD7/vgyb4jwmoM3YCPt0PZmTeadW3/UnOV9kunpUVUTe8cLeeUIaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=osXcrfhA; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2f7020a928eso8607383eec.1
        for <cgroups@vger.kernel.org>; Thu, 21 May 2026 04:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779362898; x=1779967698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtjszhJJZ/cWn5ctRzPZFVh9lS+1tvhxhH2pqInaGro=;
        b=osXcrfhAVjJ8xScCZPvjPP0yJIYD+yt2DvNfEm8wfwc1bkFynOlKcVT2nrAq0lYeoy
         hii/F6fVUKtWtR3rwXdyE2aMmcd7qOUb8L4r+4Tu5Jzi+XN7925KyNZ+olKEZXpnaE4c
         lNxa3mRrgZfgUwyVeIFkmDbQ4q4UWmWvnW/96N2qUYeY7V6c494rbEF9s7rM6TuKk6fc
         57g+BCRDzG5YEDnWAJfe8NLbMIscTT+Y95ABXZqSxHc0i1GVQ6YMdzI92MmAPOJKEotE
         /raq/J3sk6gEipMEUUfqKDoFD5y2b741E9zmJ2frYjDb/wLmOok+UnYas+rWdldENmsj
         5qdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779362898; x=1779967698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VtjszhJJZ/cWn5ctRzPZFVh9lS+1tvhxhH2pqInaGro=;
        b=J7hLrsrdq4DtgcWLyTMnPz7IkjOat+4ba2+890m5uQkfVCqAOzYioWmyhGKyDsLQjT
         3+XQN6BkaSovD8CmiNXUmQymSpuiOtjvYLuKF2jMbZ3KqWLpmOfrNTYCpT8Jnu98WNRz
         lvgH6isVdrdmIK+b3qVbMR4g5skveeRdTSBIiaAWOxBnPjgNNVi+c4KbjHCPUlk8Qb5Q
         Lvfxo2doUs8Gl4ofCG2xHAcfP68t6gMgcM3lDdTlu7y56vDI7p7CGilcp8sb3DP/GF/J
         lSZboUhot1vFRDCCbCNPUsYp29HnTRi5yJqi9cw2GAWnsK7Jg3FNF4eukv76IhKFONly
         IKuA==
X-Forwarded-Encrypted: i=1; AFNElJ/arZvJHz8KofQEeDZUQqENe1fuO2d8VFT/Eylp23LOlfQ1AaqvVKTe3NdHd8huqRhy1v1zzEoF@vger.kernel.org
X-Gm-Message-State: AOJu0YwI2FHRf5G51YPkIVw1gRheltiLRKPtNKfNzlYcHkJP+THwHrFw
	nUDOXf87JjzkobkbGcr/Lv5Isl29OhplJLN7+/h0C/fgXgJjL8/RIu14
X-Gm-Gg: Acq92OFj7vqa4406BRekEDOUykSSRpQ3ztpJGxPpdxM59QOO6wPhy/HvIG7WiWL++2X
	bgj1scx+3+ZiZoaP8KAgQTcdA3V/1MOQD/Ox4JtWLU07A/ori0HW5soiu7xGkJMGpf7OT1PHxqF
	G2Uz/7nLpm7z52U2fo1BO7z8rZRVFmh6n9DDGppJJPToA0KZNeMOxMr8KV+OoEyrbEvQngZakdv
	igqUp+WXIsya6F34/H3PP3DaEqoV/hF7ZsCPV2LnqHawvBp9rm0GT8zbb6LoD4rWiMcL7ccxmGl
	LsYJ7wKtgHhz7M7dla8RcpMIp7jkU/KaJuyRAas+r/v/b/qvecFK7cmnp7xsjiDsZ3mp/rzIeyO
	dJg4Y6SRvF822AR+gDXt0B8xZX+gv5Hrdlu/Hy83HRN8gLpO1PkKUkJWjls2t/ycBoP6LSiinEg
	CCCaaDBQ4In0RB2V8IPl+wuqVbQUWFImY6MYxImJR85dPYI64/h4+4
X-Received: by 2002:a05:7301:6509:b0:2d9:db50:c6a5 with SMTP id 5a478bee46e88-3042ed45707mr1596574eec.0.1779362898201;
        Thu, 21 May 2026 04:28:18 -0700 (PDT)
Received: from wujing.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304435be3ffsm270167eec.26.2026.05.21.04.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 04:28:17 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
To: natalie.vock@gmx.de
Cc: dev@lankhorst.se,
	mripard@kernel.org,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/dmem: implement dmem.high soft limit and throttling
Date: Thu, 21 May 2026 19:28:12 +0800
Message-ID: <20260521112813.62104-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <c9eeee76-25a8-482e-9ef4-74971537457f@gmx.de>
References: <c9eeee76-25a8-482e-9ef4-74971537457f@gmx.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16154-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 455035A404D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Natalie,

On Thu, May 21, 2026 at 10:52 AM Natalie Vock wrote:
> Interesting proposal, but inserting sleeps on allocation is never a good 
> idea and doesn't work like you might think it does. In graphics driver 
> land, lots of random things may result in buffer allocation functions 
> being called. 
[...]
> Your approach could lead to every single 
> submission sleeping for at least 100ms, thus permanently destroying 
> performance.

Thank you very much for the detailed explanation of the impact on TTM and 
Submit IOCTLs. You are absolutely right—injecting sleeps into the charge 
path, which is hit frequently during buffer validation and residency changes, 
would indeed be catastrophic for GPU performance.

> Maarten's suggestion of preferentially evicting memory that is over the 
> high limit sounds like a better approach.

I agree. Blocking the submission pipeline is not the right way to apply 
backpressure. I will abandon the current sleep-on-allocation approach and 
focus on implemented prioritized eviction as you and Maarten suggested. 
This ensures that reaching the "high" limit triggers a meaningful reclaim 
action rather than just stalling the GPU pipeline.

Best regards,
Qiliang

