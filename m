Return-Path: <cgroups+bounces-17567-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uReuDyNxTWp/0AEAu9opvQ
	(envelope-from <cgroups+bounces-17567-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 23:35:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 302E571FCB1
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 23:35:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZjCzsYNh;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17567-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17567-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56F7F30080A2
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2026 21:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355E7430318;
	Tue,  7 Jul 2026 21:35:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A24B422550
	for <cgroups@vger.kernel.org>; Tue,  7 Jul 2026 21:35:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783460126; cv=pass; b=Ye4L5S5kYh8qekWzwTLM72OjbNbqOCZV4cD2FUQJsEcCLJYE4it57Ohy+PZk5FjXL/ahs33yfGFn9pkoabpvAT9mphJOhipf8js2GrzW4P1zxk3TwPD/UJHXDre+vhOpuUyHpMupJiSQtGraxc645fJdDH3B3IirhSNOXmfG9/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783460126; c=relaxed/simple;
	bh=6TvSEo37Ek9lu9N2ZPyjBCqwdDE/+51lgxZ/UejOrQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvuSLr7n4DECXNlgyLahDsyyYmjArR6bR106RjDvUYb7VPB8qkWuD4VGZYHWgjIhAd5X14xh4mt7o9KO1wtPxjqYQoC72zvbgvIGeuUUVjWcixf4o/zqemMxQWWoAef7RVXi6cU4NHf2818pwV4jxQhsaqUDPakKssGOXleS5+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjCzsYNh; arc=pass smtp.client-ip=209.85.208.178
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39b3027009fso282911fa.0
        for <cgroups@vger.kernel.org>; Tue, 07 Jul 2026 14:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783460123; cv=none;
        d=google.com; s=arc-20260327;
        b=lToqnN2+zuxJeyOdS9UsVZmKByMDsNDVlbd9k8AXUNho3CXGB/AllXZWpJFZ6EhOWF
         PQVAuOue+PLhIaNZJt7iuSsJNkxhPVf0yuGOt604IIoZjWNNm6rb6pET/ZmW/wgz8UZm
         POA9aOtTtbe6tARxo7g8s6YziVUB9EnrpUaPDWVngMiqCGVbohz9ItFUWiKBs/abPOPN
         kT24mXYhQEithQE2RdhUe9UtRgylGo68+VzuJL/3GdLi5z0mgWC4e97ArbW7t5vAqfDN
         yl10Rb+7K1+uIREwjChQmN6SESZ8v3QunNM4ZmUKn18KevcDtSTmzUL5IteydD2aqU05
         B60g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6TvSEo37Ek9lu9N2ZPyjBCqwdDE/+51lgxZ/UejOrQs=;
        fh=s1DSJd4+KBcks4RHojDlUVmSv4yWfPfo0az3HPB3k3s=;
        b=TY+Oavw3czBgkjQjlb8UAfG24yE1/6j9cwzJC53Yq3VwxRHla4yA5gJSeRC5ZRt1ci
         p8BNKBrEDynR1vmgnMcgJkzt0BbGVTOUkpZtWs0Cnc8/YiqKTmAVG30DJ5cU8UBEhwi2
         bM+6t60UExff6sYRcm1NoKUM27qO4RZT/JPR1piZyOp+NRya5InN7TfaextUbNe7q7Ee
         IjPYY1RFq1UVWEKH4CiX7SszJgV1x7UsvCq14xqFIslm9ZfTqKzvZio62jZZn3V21FnT
         IvCgiFORUgpjjVbtLuZrZ+f/pynNvrdGsrYz7VxAfIWGz0IKLAAfU/Z9NDuqEp2i+mop
         u24g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783460123; x=1784064923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6TvSEo37Ek9lu9N2ZPyjBCqwdDE/+51lgxZ/UejOrQs=;
        b=ZjCzsYNhE25WrU5epO1JPGoPjEXvLjwdIplph61GHD77P/4woC4xd23Gc5B4qVz68A
         Pn/g9MJsWWeE5C35ssN8dFc4lGqAhIvD3Nh1bX8vNjCWpmHMRXRJQ9qXy0XEV1bkhqMX
         7ETpMraxlSGvEBn5UeHHNF47EKcy7/sUtoI/OuDg6LGdVwsWn1YFYq3+8pDIkHobx3N2
         Ap/1aqArv/vh7wntoDmElEcok9ja6y5bkxC/PrQt5WgJVUD+i57hDm56vI906DR/9v7V
         Md378Tc3IH0Zyuky7OFPjZRgJrieBwDIFeppYqzvfnNYcO0XGrn5LA+NePYfmiZAMP7n
         3Wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783460123; x=1784064923;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6TvSEo37Ek9lu9N2ZPyjBCqwdDE/+51lgxZ/UejOrQs=;
        b=GQWjScZ++J5j9MYnOq6+63C5LnuuLaPDeTkDwNCoJ238kMUF9us5lphNRN2BjQFHQT
         t9zmziEtkc52DTu1p3Zcpt3ussvoj/ZL8Esr6AaTD3NLMNjSilNF2UasUfzDr6Iuc2Qx
         4HML/Jnk90GkdxtMGCM2fMEF82Heo1FM1YDdXtPE+YQXbSXuZELSXJY0dHkGXarmUEJt
         GT1rVKzEmR3MlGmHBByQz4nPaf95vPAeJSzzbaZfPrNpSwGpN1ipM/XuOwy9p0C7/ICv
         6jwXYCS+rpBOq2Zx3UM3az9jvLxE8UE0lZ82CMnB8dwEiXjAxj6vxXsM+x5CfoaG9K9a
         1a2w==
X-Forwarded-Encrypted: i=1; AHgh+RrMnbFbv+IcWWcEcUUAV+Fw0jsdP2YWJugL8+WYFZG+SMA14+wsv+1gxYy4qu3eMKtf6qZ4I/dD@vger.kernel.org
X-Gm-Message-State: AOJu0YzXqZkXdbnmu7UQwZ4qZpE3YZv22LTVtmiG/Ukr1MBWCBaMfj/M
	HvbPYlEbd0Xe+z6TRo98gE4elqvxInWd1W7Tp2MbJ6A2+ewtWk8mlznXysQSMEUB0OqcyKx+B+o
	ATtgGYM6OIBgKIenn+DPaJebDUUO/s/Y=
X-Gm-Gg: AfdE7ck8FuQbJZwPLFOOYIgSonUJyy/kQNl68pbxYFPpoeymGXBME+EFKLIyPD5zBoh
	LrXKdXdLBOjEgFbH6p5lnyeJu5RfbTmnq5RdRJTKFPgwcYLtf4tyKUVFfzUnbAZ4XxLAXd+T1QB
	iExJ1SjZutbO1Yfws9tW0dPZ2JZyDd1ZqaDMi3KQXcZWYuyRaK0HfcVbxuAKcUoAdNJrlxUIUFf
	FxqE2kA4gSD1LijT/lSclkWP4N2JiMUsoO9DxzoLCUs7gZY9OWJunzwvgmEyIxrP5nzTEkCgKF8
	ro8f1Zjn3xj3vxZcss/RCCWh1d1J
X-Received: by 2002:a2e:bcc5:0:b0:39a:cfe8:dcbd with SMTP id
 38308e7fff4ca-39c600386b8mr15519841fa.30.1783460122325; Tue, 07 Jul 2026
 14:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c0970cee-42c2-4844-b88e-229853f08e90@linux.dev> <CAO9r8zNJh65SZzdW8Cc8_8N5Wr+ORuRtU3kuaAX_DhLaESFYTA@mail.gmail.com>
In-Reply-To: <CAO9r8zNJh65SZzdW8Cc8_8N5Wr+ORuRtU3kuaAX_DhLaESFYTA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 7 Jul 2026 14:35:09 -0700
X-Gm-Features: AVVi8CcuwF-DUySIS23BW_Gdh2R_ilIjcwqI-GE5L8_I55ZKEN4Gc8qN02pks1A
Message-ID: <CAKEwX=MMXdq7KTzcEgXfNt2L-eTmAVa+nijdyiujVOAhXQsHSg@mail.gmail.com>
Subject: Re: cgroup/test_zswap failed with "zswpout does not increase after
 test program"
To: Yosry Ahmed <yosry@kernel.org>
Cc: Zenghui Yu <zenghui.yu@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	hannes@cmpxchg.org, chengming.zhou@linux.dev, tj@kernel.org, mkoutny@suse.com, 
	Shuah Khan <shuah@kernel.org>, mhocko@kernel.org, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:zenghui.yu@linux.dev,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hannes@cmpxchg.org,m:chengming.zhou@linux.dev,m:tj@kernel.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17567-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 302E571FCB1

On Tue, Jul 7, 2026 at 11:25=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Tue, Jul 7, 2026 at 2:38=E2=80=AFAM Zenghui Yu <zenghui.yu@linux.dev> =
wrote:
>
> We were discussing a way for userspace to explicitly trigger a flush
> before, which would come in handy for testing. However, we decided not
> to expose flushing as a concept to userspace.
>
> Unfortunately I think the only way to "fix" the test is to allocate
> more memory, enough to trigger a flush on most interesting setups.
> Perhaps we should scale the amount of memory with the number of CPUs
> so that we don't have to keep playing whack-a-mole.

I don't have a good idea for writeback, but for zswap out, would
MADV_PAGEOUT work here?

