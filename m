Return-Path: <cgroups+bounces-14164-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ca3CQyvnGmYJwQAu9opvQ
	(envelope-from <cgroups+bounces-14164-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 20:48:28 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D07717C82E
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 20:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4C9B302EABE
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 19:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C00374186;
	Mon, 23 Feb 2026 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVAdbWdf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74C92566D3
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771876105; cv=none; b=njeDmY/Tm4YbBqcbmSbg9NrI+hPBg5ydAFklObCpUkPej9FLm9lisTrEdgLhoswHDEt9Yp9ZjOWmmGKzZMSZFRZAp9nA2xoPVHDfu2i2jIH8mvPcdEaEeOZomMacK9Vp89I2nipYM5Ws//xt8ltMqUMM3jnj8EJtXoGxre1L3Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771876105; c=relaxed/simple;
	bh=LcIntr3UPvK4nnaY9JfI+YpOKuwEh9BW0xDhYkKUi40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEcw1cTc6vgFYeilW/ciprmnucZg8w7iEBsfAE62l8A4fMpbOVlMHSpo8+rRLr/o5+MrkStEftEoxrGXBNS60twuH72iJZts75/ZsvgAzcKEZ+JcXZtIDmsUMDX5rJfmNTluPFWpZ0KRbR3XJPi3ybSY/r2xzi1wVYEiU1kj9ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVAdbWdf; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7d556c1a79eso1007185a34.3
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 11:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771876103; x=1772480903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CfRIPVejaQzatmaR4Ji2F2t82QsJMy6YrYIwzm22g/I=;
        b=PVAdbWdfhHdL5kFlf5zznebSr1OXR201Mr8drcTBrTd/YxrIymjq502/S5xYNsQy6O
         NbagVtnfbM+tkjKT/vc1EOX/nDLiUS3jUNLQ+/qTBDUVwX7yfbntAyEjZWpTYixEqpDs
         LoRU4gbc/jZUORpgf6WsFNIRv58+A/8w20qZU0TwEr5z85ZvBV/gPah4SlYUFKgiM09D
         F1iXvzhwvB2K2XgBTdDiTbwqgj/6/aplXOAjmyTQ8O1Lyg3uvz4U82W9jNH/IqdF/1BV
         hp+JgmHysOweou/YB4tYE+NyWyEQ1ykAGFhEw1DSn0zbBlLBI0TB+gLL1qQdYnRgzRY7
         tR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771876103; x=1772480903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfRIPVejaQzatmaR4Ji2F2t82QsJMy6YrYIwzm22g/I=;
        b=tCNne1mkg+Bj6eN/GA42RCaCDNYzGC0B29LEcXEJSA5tXTWlqzE8X9+uggXcueSB/b
         ql/Ay14I5RBEEUjziDNxSCiEm6+IdEb3a7SYn11lc+kJEZ24fVYO8a8GzdvQN7xdACjZ
         71n5ZK0mYojmKP3JFlHwAdSigcC3t3XShfSEsm9JzWhQoNnk4R9dc7Rp55IQ6Dd5i8Zc
         yVAIAolBtZyWtGo0wPr0m4PTRFdYVNvMs1jGFWrFIG/R0VOq3PSh2vvtopxYu5U637JM
         C014Jk12ILlcrRp7KIr0QBteKB4we+9FoGL5E/SL8QunhpWVbeDNDdhS6SnxWaa8LlNd
         90kA==
X-Forwarded-Encrypted: i=1; AJvYcCXiA0x3gdVIw9LobiocJ88SBbN/R7Rq62r6UzDBVDg7eJh4lDuUQTc5Nb83+ajNpnIltw2zmVsE@vger.kernel.org
X-Gm-Message-State: AOJu0YwUVKvS2mtdVjgfP5BMIHjeDb0griykubjgMwJ/YTCUa9HNtXAM
	Rd7toZIlqHrc4ZrkltL+eW02mIrdMLpnVu1LHE9vlrKQsB/0rsyBDlJV
X-Gm-Gg: AZuq6aIBRPLE5wXTrF/bfVJbsp6rWt7lnsGKnkkLw/f/3ErJQuXAHek4HsUCdpJVWrU
	1s/nkx8sqR3HW5ZpkxMlB/m7g1+e+bcbdRtJDX5/fST8wx/WqUIyvoTeRg1EMcg7wULJtytv/2y
	BVSreGVF32y+YBAcvxJgLyeT2L0WCitE3qllsHy9p3PwKhYRd4K8xSRPJ6LSsvmv2egjUeG4eLB
	wHqG3xg6FYdosaamKeRLEaNEPVqFB9/+0T+uEFhtSDrDBsP+GiyRcg9Kvv7zAgQY5cVAj4sxeS/
	oBFVePBHUo4gEvWrobDcT9W/DvUe3P6gxz6oRHViY9YulZRn8txvoEpTqXgPFe1O/KH42gXwEYD
	hwkfaX9KsZNAqDD5vWi1m5omMdEDrUlYU0kIHq6b7TYo/fDH4sFTN7+UCRf3j88bERqENqR6TIP
	4yuW0XSbgyqp6ktmPdkWQAAptqy5E4Mq2SFEOGfQ==
X-Received: by 2002:a05:6830:6f43:b0:7cf:cd98:b3c5 with SMTP id 46e09a7af769-7d52bf535f1mr5740241a34.31.1771876102722;
        Mon, 23 Feb 2026 11:48:22 -0800 (PST)
Received: from fedora ([2603:8080:10f0:ab80::1382])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d04de97sm7756698a34.21.2026.02.23.11.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:48:22 -0800 (PST)
Date: Mon, 23 Feb 2026 11:48:19 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: vmalloc: streamline vmalloc memory accounting
Message-ID: <aZyvA32J2RQ4z6VZ@fedora>
References: <20260223160147.3792777-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223160147.3792777-1-hannes@cmpxchg.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14164-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,suse.com,linux.dev,kvack.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishalmoola@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cmpxchg.org:email]
X-Rspamd-Queue-Id: 8D07717C82E
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 11:01:06AM -0500, Johannes Weiner wrote:
> Use a vmstat counter instead of a custom, open-coded atomic. This has
> the added benefit of making the data available per-node, and prepares
> for cleaning up the memcg accounting as well.
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

