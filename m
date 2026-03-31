Return-Path: <cgroups+bounces-15141-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIleHr8nzGkmQgYAu9opvQ
	(envelope-from <cgroups+bounces-15141-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 21:59:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D23370EC4
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 21:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A98730A9534
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 19:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152C3421EEB;
	Tue, 31 Mar 2026 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="O1cot/KJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61563806A9
	for <cgroups@vger.kernel.org>; Tue, 31 Mar 2026 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986977; cv=none; b=U2WM2AXeur5o/7+LnliWcDcPlKnQiOf3yUIRz6peKayaUivZY5F9kfgw7KgS69arCM4/oE5RDhQf6BRG4NodIiwJdZXtc2/aUUtJTEUZgtPHfaiUO6I1uSm+G6B5SyZQtffBEelSul7eA/S93oKJJNFUlVMJ/lmn1shPKY771oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986977; c=relaxed/simple;
	bh=rkHmVUtsQzhqawcRPwquKhHQClG9apHQr96kTX5/KFU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j9iE1gQ+PEHsi0hfM3OQ2AogEuuCTZVrV4XqOBJjg34R3CMlB53yv0REAMAtdEXSU4tZ2+hr8kXQG2+xtK/ToF8Jl09azzEjrEaagYH0Uqm3GfVBUnj7PkzPRL7AeSUuxe9sBNcqyaekdEXLRUTMOL8BnpFaB87lT+gaHRDs4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=O1cot/KJ; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-46808125c65so2143532b6e.2
        for <cgroups@vger.kernel.org>; Tue, 31 Mar 2026 12:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774986974; x=1775591774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSRNbCN7FvakZDv0uIBWT2PiYN6gmrhFgGcsWQJHNZw=;
        b=O1cot/KJnoDlOO9yjjCSf45LoRjSeA8VE4gcpBtFZ2s8YOWLdVUUmwGHdG0VxWZihF
         LMUO84Fw6tsn+wA2OViJtMgcuNVpqigUxTAb9/7RZUqKra/XYOvRgDQSrlE1G0QGuVuu
         H5e/mjFTTTY/MsQBzo2SFWcAGJ+EthWqO3lTNSwt3u/SlkiF08jqg8CMMtw1FI7Rswu0
         Yp6J8sTzMtJpbxLCOMml4xlyWpkkxtzNEZ92apF7Xu1VwrFGpeI7X/Ck3lFrIbU/eFdD
         OM8LGOkO3vM0/kmEyvezHg7DNFizrzlDkEpmTh4fIDd2zW6zxGG76SnSNf9JUgpq8GPy
         N5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986974; x=1775591774;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mSRNbCN7FvakZDv0uIBWT2PiYN6gmrhFgGcsWQJHNZw=;
        b=ddGwSuGRnv9HN5IdI7ignQKg9dw8rlwsoxd7n4AsrZ/bywcQ/hjI0OPOwWT1gEhF9+
         LZIa04IvTF85eGdFnAlNndtYer8AFIYRhwKq9YXNYGyPXNtG094Cg1WNV4Dx7M/5tSIA
         rdwFPKPHyW+Scf/hk3cTSUgmGQ+3IYUZuly5+BiCKXxi6ViXTRl+SQvapZMDvkHqUKK+
         aFjstFCZS/iP56jcCW0icP1PQstXFc8TNZGX4od1Ctp6hurDxHW1wIgfTSFwD3uBbafJ
         TS4nA3U1ISLk6tZu+Tq0O7YDtX4jwGPDZhOp3YUCpmrKyS27SjCiCpL4SZYgyIBoNDQO
         qbaQ==
X-Gm-Message-State: AOJu0YxD0ehH2ZqTwkEt2s16mqI0vKHcI+KDpctYWaKqXGHSMhkTwZEh
	NxwoVoEWFhRgfD3uERmYyJe9MeaZpjQK+N10+6y21Vwy+565l6Dze3H+46sPQ8P8O6M=
X-Gm-Gg: ATEYQzxZm6tQwI+7dTj9WhX2qxXzR0Y8NbeujmzcADHmehL3qY+5WOxh4krtbdCIVGb
	J1prEEMpPHaJGza7BgFFFhNhH/r4GO75dXJEefqLoVDLyoyIYEM97pfwOHpncPrh5GikaUBQre1
	zKjzFnk2j699VVaky4ASB07HZnP84AC/KPQfNqHoowsb0C8aDb1/uHEdjGtX9kmhZiAb90Buikf
	/Xpbfdv0cAQN0cUvAZx8gkynNhI/xsFnRNsW1+rCqKX5/A+biUoPmEXwSURzRzFRpy2CXRoGRPa
	nBMdPy9Zm7vkuSqIyuTf4XBgM9Pa2GYKYacSVrFGbB/eKeZpyZhZESlh1dm1RTGfT91CIvByLEb
	3j2QG0YpQws0S3KME1238WWsrP4wSqlFkZCYchTA2/bqhURiqgGRpS0A5HJcyAlNN8vKddpU/O/
	L+xkC1R4+eNK7DDUPAZeM8shBLi843ZhYNC5BGKUo0VsgXZCLjOjgJleUHlj+l8vZwaQ7q6ZWZO
	Xw=
X-Received: by 2002:a05:6808:c168:b0:467:f567:d609 with SMTP id 5614622812f47-46ae01b5369mr410934b6e.34.1774986974504;
        Tue, 31 Mar 2026 12:56:14 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46a9fe94ebdsm7360212b6e.4.2026.03.31.12.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 12:56:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, hch@lst.de, Jackie Liu <liu.yun@linux.dev>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20260331085054.46857-1-liu.yun@linux.dev>
References: <20260331085054.46857-1-liu.yun@linux.dev>
Subject: Re: [PATCH] blk-cgroup: fix disk reference leak in
 blkcg_maybe_throttle_current()
Message-Id: <177498697359.21114.114115026638001310.b4-ty@b4>
Date: Tue, 31 Mar 2026 13:56:13 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15141-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2D23370EC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 31 Mar 2026 16:50:54 +0800, Jackie Liu wrote:
> Add the missing put_disk() on the error path in
> blkcg_maybe_throttle_current(). When blkcg lookup, blkg lookup, or
> blkg_tryget() fails, the function jumps to the out label which only
> calls rcu_read_unlock() but does not release the disk reference acquired
> by blkcg_schedule_throttle() via get_device(). Since current->throttle_disk
> is already set to NULL before the lookup, blkcg_exit() cannot release
> this reference either, causing the disk to never be freed.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: fix disk reference leak in blkcg_maybe_throttle_current()
      commit: 23308af722fefed00af5f238024c11710938fba3

Best regards,
-- 
Jens Axboe




