Return-Path: <cgroups+bounces-13944-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B75Aznyjmk5GAEAu9opvQ
	(envelope-from <cgroups+bounces-13944-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 10:43:21 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AA91349E0
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 10:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B90730B971B
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 09:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4F934E751;
	Fri, 13 Feb 2026 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAjigQqe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AE02417D9
	for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770975744; cv=none; b=OEKfaZzRir8RyrrEOV7VDfgqefmnj622xb9x+i8L6TwtAA8LEtIeHAUpFNXnnpxI46lA1JtD6ALhKfIOUmt+wonpXi+h5A2eYz3dJgtCBMVKMLm62bILJ5NYsSc7AKfgPfMNXTwiNDOWIltASsaVQK4Kmm7S7xCb0LK3aVcWFUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770975744; c=relaxed/simple;
	bh=iPx/p1PDS2qSP5J+nCZnQvpqGZRAvVSgR3VaXJVUIuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNFnIIlL1ZfV0rGDGRreaZIqEFJbh9v7//7/WYpVOcqZX9uC52vuWJx91o9cpuBZeyJdE+h3T+iyKul1zoUbDhqlrGQfWtFXShu0huRMG620kru1Z6iQHysNBdAomwJZPyeKPAIROB4KGNNyuyW4UaSNl1kmwaeERBaUb5+soMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAjigQqe; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-824b5f015bcso1035480b3a.1
        for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 01:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770975743; x=1771580543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9jdm9e4LpehRQOnSCiausys9F0ow8LvB9lV5cy/oWQ=;
        b=iAjigQqeQCWezymj3tk4db3Qdz+UawGyG9f5LegvL/mpkErfrC2DXVUqhcySBdEIMs
         zIIXndROL6VtD60wG5w68zd3aCXqk6nfAyttSKwh5piw+4Xam5c4kiz6OrMHXwPL50uk
         wNDPtmwxnu7iHJfi5JwP1GZduZRf9zuntRzn/rUJtA2NYt+4fm5cDhDHBZdFkpjAncJ7
         B3yExDo8kSb0MSEszQ4P5NU/6/gGjkhz4mXdopTdlas6jIXSgPaJcJIvMwBVVNovxgXg
         HPlBDtlUoSpt/cYNqcC/XzxFZ9UdqFM+CYMA8qF2HQVzRTz3hZSNZFhRqnrVBLMB6h0+
         goqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770975743; x=1771580543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H9jdm9e4LpehRQOnSCiausys9F0ow8LvB9lV5cy/oWQ=;
        b=rVSWblxKOtysSE0KmeFIj9tjgn+xTp5in5CoLDcx3elYOpCcCRF93OZ0b9ZCv5KLX4
         br8mhXE1aeZX72BsRn3VRVDdylM1arKvByC0rFXAAcjhH7OLEv4JWLyRcvzV7jdiSAvK
         /R/pduKqEsYFvJK/+0kw1jyfU4mxi+cpyJYHS0LzWfL/q6YgjX3cLsHGtsymSiUA4dxi
         sB5Pa7sVszFIBiYkEc02uqFSZClHXSEE2Tp2trjInyZ4ONVPjDggVwEgNcjdDSHFDW0/
         JnlJAssMRrz1TTP3eAhapnx29j4zjzSxpkXZDQde0mZ7fg2fh+fz9xZ7xD2u8YrIs3eC
         eKdA==
X-Forwarded-Encrypted: i=1; AJvYcCUeR8vFklyQ+7QWDAtqbHzx0sWx4bV6eUHJBf785lg5eS8lt6fBkTkhd/cJGsZcLTg6DjXA0a4M@vger.kernel.org
X-Gm-Message-State: AOJu0YzN9AxpcYlDAm3kR1Jtee6kD5AWq1IX6VsVKUm5BIfTaoPZUP3B
	ew7QbFVS75zUXNWxrXLOvnJGuDqpoIxDf8h1flLGWLau3j1S5Q7ebV2N
X-Gm-Gg: AZuq6aL3LBSD7go2gtXnjFEhGz5tMtjgb0ni3KOVBYkBEc07tKQcXuDJ9Dzb/QpZTqD
	xgwz1775FddF7kvU0T6Xu1VmCI5oWgEhT1rPbFctb9kzFrq5BalE/+5ZE6HffrfVQ3oLnJ/fNCt
	YXO9vw5b6Ckn5cX0US7szhADfqJoimDCWuOJg3lQLw2ohd4uhG0wtFbXdzsV5eNo5PpKVrdtZ4h
	+uv0jy1qpzCki9h+BI/ZVl9v9qoXRcB8iHDCnXb56oIOj5lbLCDEIvk4528w1HMihtF4AVfTtxX
	h0cPynQHu4fCw5QXOAFyncAs5EpbQCiQg0aMSVhJ+aaE5x7SmSQZ75RFZ3SZzPAk47hWx5+sAy/
	yBzu8X6sWpkJucUcKI1Ow+RucAXnnzvlpFB1Rv9W6Z8/qKAVU1W3Y/xEZlQa5mVeZfUCYYtSbu5
	5T7a25CZWTu08N6Xmk7H1fg2DtQU5fPu93mQ==
X-Received: by 2002:a05:6a20:2595:b0:38d:fe2a:4b13 with SMTP id adf61e73a8af0-3946746db87mr1876262637.77.1770975743002;
        Fri, 13 Feb 2026 01:42:23 -0800 (PST)
Received: from archwsl.localdomain ([117.184.79.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e196accf9sm6996720a12.13.2026.02.13.01.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 01:42:22 -0800 (PST)
From: Jialin Wang <wjl.linux@gmail.com>
To: wjl.linux@gmail.com
Cc: axboe@kernel.dk,
	cgroups@vger.kernel.org,
	josef@toxicpanda.com,
	lianux.mm@gmail.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tj@kernel.org
Subject: Re: [RFC PATCH] blk-iocost: introduce 'linear-max' cost model for cloud disk
Date: Fri, 13 Feb 2026 17:42:18 +0800
Message-ID: <20260213094218.253536-1-wjl.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213073829.182168-1-wjl.linux@gmail.com>
References: <20260213073829.182168-1-wjl.linux@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wjllinux@gmail.com,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13944-lists,cgroups=lfdr.de];
	TO_DN_NONE(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,vger.kernel.org,toxicpanda.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 88AA91349E0
X-Rspamd-Action: no action

> This formula correctly models the dual-bucket behavior of cloud disks.
> It ensures that for any block size, the calculated cost aligns with the
> actual bottleneck (IOPS or BPS). This allows the system to reach close
> to the provisioned BPS/IOPS limits without premature throttling, while
> still maintaining the latency protection benefits of iocost.

This model still has some limitations. Under workloads with mixed IO sizes and
vrate max at 100%, it fail to fully saturate the hardware performance.
However, it still demonstrates a clear improvement over the linear model.

The following fio benchmarks were conducted with two cgroups assigned equal weights:

Cgroup A: fio --bs=32k ...
Cgroup B: fio --bs=1M  ...

Results:

Model       | Cgroup A (32k)         | Cgroup B (1M)        | Total
------------+------------------------+----------------------|----------------------
linear      | 1137 IOPS (35.5 MiB/s) | 79 IOPS (79.5 MiB/s) | 1216 IOPS 115.0 MiB/s
linear-max  | 1781 IOPS (55.7 MiB/s) | 83 IOPS (83.9 MiB/s) | 1864 IOPS 139.6 MiB/s

