Return-Path: <cgroups+bounces-14236-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Bl4/FgBLnmkOUgQAu9opvQ
	(envelope-from <cgroups+bounces-14236-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 02:06:08 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC5318E848
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 02:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75B8730B7826
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 01:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF01923D7CF;
	Wed, 25 Feb 2026 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQSKXLy4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400351DDC2B
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771981475; cv=none; b=CwPevgN+sTqk4ul8YtwE1oOMtdCd1ibUYhdU75kFrBd0zkB9wIj9XBQ6aYSMJ3LrcfrykaFq9zS3t/ednA1irnv3fi1XYJZMk0kDkF5ZRW9yuJ53d+3dG3JqcwIEmX1cmK14cyVlszSHIE9iw/E482yOwq5MrOoqZ8XdFfj8FGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771981475; c=relaxed/simple;
	bh=em6SncChhsNCmZBW0/ZxL0iTGmVt5uomb8OIqPmIz1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6OqvroG5c2N0DGx4gJTUZBvXWLaUNMy/GrArAdvAjXUArZJpnX2ZY0cNPrwXFYiHU02+ENEiFc1RvKHF/u6wLir3HtmkEPdTC1um4Y70UA0DhLo+GH53aYFz2U2lshb2tXM8+XqwA2FkWu6nmgMLE4xP96vbGvXO2JFtzh9ML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQSKXLy4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48371bb515eso76056185e9.1
        for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 17:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771981472; x=1772586272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91/bJkQNN7qyadQSoaiseSGTAeJs7mqrmAw5bCkfU7E=;
        b=LQSKXLy4N81+LQ9dnficvxoDfXFWoYgbdMKMOUciAGJlx4yrli3/hpBfkC+CPEaDkK
         wP+pulM8SllstFNXhYbKIh8TcPoxH7AjkDwA8eQZ5MOztrxYp3t1Ph/1JgEhVDLyoSy/
         coeqX8HEdUmdbm/ioojExxv5r+VHVcwOJUha9NoZ3dHnVn6tPxIqBMifRci7hujfZZiT
         gJuVniiUH2iZJNBWMQtFomg5tnTNDCA9ScCvXoH4EwIAyUunQyVwjLF3nUSlbamo8/Zi
         r+jfdOMpHI9dB17y7Ow1MdZebAGhDrhIxfUFX5egd5oFnf2PTheUw9hvGM8n1LgkGjpZ
         zIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771981472; x=1772586272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=91/bJkQNN7qyadQSoaiseSGTAeJs7mqrmAw5bCkfU7E=;
        b=b5gJNVNqwt0omQA/sO1cNCR6XGeRM9IOeonPRQyvQ/ENG6VLcwRSN3SQoB/Weiguuo
         2edw+Dn52tulIowNwguI5q+X1WoeJJ2tSGFrYZgDewP8DsEBQj4sUe4FkQhxNKv0a5eh
         Y3+m0iqStzIRzkyRkAFHqAsi2EemcGR3SHFvi2b1NaK8+ukEJhhNy7QpzPzEkAif+Skx
         Bm3XogF4mBXBpgbnmkMWRT4aEht4HvpUI/7n8q9TxgbPm+qt90zk7zRDuWtMqwhaJHPn
         TX95SguWEYgQcc6qdpd34UU9Hx4kijD/K6tpBPT98h0AUT+Ul+TmVN1TIYwR2/I4Pmzf
         t6hg==
X-Forwarded-Encrypted: i=1; AJvYcCXgncguShSspC7l3GnCJ5JWTeUICpgDSm8pocpz6/VxaPhggaEC7aa9zj84poN0l74eEPKZScWe@vger.kernel.org
X-Gm-Message-State: AOJu0YyL3hEeIbwWAcjKQmZR0p3XnXTbpWg2d1DE3TMPBf9A1H5csmtI
	Fa0b6j6rQIOl8L+EfFr6iWR9tVGM2UXyJTbwTSqr8A5stH9Bh6+lVolT
X-Gm-Gg: ATEYQzz+dgslOd3GyqylcC9tjM+yCWLXp5RkfAAOdBbcxrDpB9OcYYpLu8wG3BuRfd8
	jPcDrFB97OZU433fSM9DIDdtmiLJX7jADL3nwAWkInLHKrX98boo8obSWXRXezxo382UHCjhFBh
	aQABKzjrWKd/w3+C+ngkEIxnUu0zi3kEts2VYTetfm/+eEwAaB0UVSfEysF6wEtvRluihmZy0Sr
	4q7ohKzKM6RvXJ4xaCGW7OnnGY0wtN14LrYJ0oiX5c3WLqsYIP2vzYq6fN3Er7HG7syRGfioN6X
	fzH32wZU5N2z7vcrOyGdVE0sy0XFFXq0MWU20PZqIkVYuuHDfGB9MCcdcrjwpcCb+PTa3QehSTt
	I0w6mYt/Clk7NiUyaZmSmJp8tgqJYwU4Ptr1zumVFKXVnNEERmpjGLbRkqYu++5PeSPiN517I5J
	GXtOLbfZMKQy1mFLQbbc2azwgIz0ZEfA==
X-Received: by 2002:a05:600d:640f:20b0:483:9139:4c1d with SMTP id 5b1f17b1804b1-483a9607e3cmr199650505e9.14.1771981472242;
        Tue, 24 Feb 2026 17:04:32 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483bedda2d3sm4976455e9.21.2026.02.24.17.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 17:04:31 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: nphamcs@gmail.com
Cc: akpm@linux-foundation.org,
	axelrasmussen@google.com,
	baohua@kernel.org,
	bhe@redhat.com,
	cgroups@vger.kernel.org,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	christophe.leroy@csgroup.eu,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	huang.ying.caritas@gmail.com,
	hughd@google.com,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	kasong@tencent.com,
	kernel-team@meta.com,
	len.brown@intel.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	npache@redhat.com,
	osalvador@suse.de,
	pavel@kernel.org,
	peterx@redhat.com,
	pfalcato@suse.de,
	rafael@kernel.org,
	riel@surriel.com,
	roman.gushchin@linux.dev,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	viro@zeniv.linux.org.uk,
	weixugc@google.com,
	yosry.ahmed@linux.dev,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
Date: Wed, 25 Feb 2026 04:04:24 +0300
Message-ID: <20260225010425.2876986-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260208215839.87595-1-nphamcs@gmail.com>
References: <20260208215839.87595-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,kernel.org,redhat.com,vger.kernel.org,linux.dev,csgroup.eu,gourry.net,cmpxchg.org,gmail.com,tencent.com,meta.com,intel.com,kvack.org,oracle.com,suse.de,surriel.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,bytedance.com];
	TAGGED_FROM(0.00)[bounces-14236-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BC5318E848
X-Rspamd-Action: no action

Nhat Pham <nphamcs@gmail.com>:
> * Simplify and optimize swapoff: we only have to fault the page in and
>   have the virtual swap slot points to the page instead of the on-disk
>   physical swap slot. No need to perform any page table walking.

Some time ago on Linux 6.1.124 I typed "swapoff -a". OOM killer started
and killed all my apps. And "swapoff" itself eventially failed.

So, it seems swapoff is very destructive operation.

Please, make swapoff non-destructive. Or create some alternative
non-destructive swapoff. Such swapoff should try to swapoff without
killing anything. If this is not possible, it simply should return error.

I don't think optimizing current dangerous swapoff is right thing to do.

-- 
Askar Safin

