Return-Path: <cgroups+bounces-7278-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A397A77A2F
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 13:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D051672F3
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 11:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD5420126C;
	Tue,  1 Apr 2025 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G/37PlTe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72611F1317
	for <cgroups@vger.kernel.org>; Tue,  1 Apr 2025 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508668; cv=none; b=qUhcf0qPHP6z/rSkJWq+prWbN9UpboyL5cFneQj6eC1VWso4hNdFmFiBK0dhLYkrFZAJV3lgrxyEXFHDol0k3Ds6d490VqxpC+7Z+cDHx5+hRoFULe1wfHtSseRQmZAW4lGrPfr7KqTalGedT7lU9a8xsfpR4OL+uqBIzW2Fi+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508668; c=relaxed/simple;
	bh=l7kYpJSyNb4LT4PNP24Ib/mZ3/rLHCzQ/AGuD9oUJk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SIiuiVq6SFImMMY4AIgAJGGgosleDrwlGZGmnRDzaYx3Qq7LPhw16JM4ywIA1ZE9m0Driexf/h5xPxMBGcH01TjKj6xHh421qNjz3hMSlEfS4jHe8rEewWcaOlhQ02JMwbMIrMu/ylM5X6Jk0w1qoy0LzItwCWQTtjsaxcXhfpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G/37PlTe; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso5256344f8f.0
        for <cgroups@vger.kernel.org>; Tue, 01 Apr 2025 04:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743508665; x=1744113465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MjzUBL0mWJbDDZlrnw5hFFgQWXS6aH/9lQwvSCFdxu0=;
        b=G/37PlTe6dVwtK9jB1BqXUvwRl+5HIqSeAa7rNxVGIkKQUhMT3dFtMPXFYxQXkv37U
         hcLg+ocC3N2ycdiJ6F66js4JvlqYZ6bQdRB7YtAITOpWmTVTXE2NSy/7QWyF6WvvMWEW
         h8N0VmWCEnfYX7W0N1U4k/L5ki0UDlSJYQAMLRiKGXWixqD9J2D2DeBoEPPBRAVhMeYR
         oDe5Q9ZidjV6wl1vRF+MPqFux1l5r0LNICOYE/4zXOR6FMVm5AzSebk9EVyAfKUF/Fub
         2zE4b87Vz8CGvhJh6+Z+sTkOK+mRKcRKg6qoMm3jchj52NISDvRCVFx67aSGWSEmNU2C
         axFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743508665; x=1744113465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MjzUBL0mWJbDDZlrnw5hFFgQWXS6aH/9lQwvSCFdxu0=;
        b=RDR1ky/2rvgXz26xIyWiwiwdCXwBH1k0VF6m9w4RXoNPM8fNxBMGxKtC77yYC5isGs
         VK9wIkXQaKshLErVJrkLxeACMUABPUT4d5jlze15p5ZFc3L7zuzMlVU+97btq2FjBXWZ
         UvJGHMm2KtPsGlPy6OW51JU3NT//rgys37ym2YbXXKjfYuhDs2Z8rJF1I8EcpTBfC6nS
         yqKAJM3uXQM4ym94K6ynPbpsAbRzWRvCcfbNoIgSzhpspRzZO5C5BsZtt+f5BrEeWmKC
         TOAw0nQRr86eko1TiLY28Q9Rm5mKE7cF7//zk21lJvYJrpFQJ9rI3j/zn2joH/ePfWaX
         7SDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlP5UIx/sl7g1qqoyOd6L9GD9Hr8kW4O8T3EJ+5Zjx5/q4dPpvPNd2NPToco+XfeqVCDiwwEPH@vger.kernel.org
X-Gm-Message-State: AOJu0YyrJ5wbl6VRnKa83xsO50oV5Irg/nOINr3FIySkJH78FB1HD98i
	+oYyZauGJX2UyHpIECW9zQpggyTLUnwnHQ1qJ1qXiLdiHGdd5iRNdFlGsb+m/nQ=
X-Gm-Gg: ASbGnct/9BUX4eIdgDPdcRf0HyJBvk7NIjLf/scmw3ulh99YjNaF5nxBjarLRn/zEEG
	0MTfgWijh8KlpZgg0zwMTuF3L7GYWjAYkW4fibvbNMhol3Zp8GFoJZP+bhU42cByGNg0Qh3eqGf
	4YzUM94H4tWU7CZrUkocpZgEcceLVaHPTSAM+UFwAfFlWAwFAAMz8mXakkPr0J+BVELozD61XUj
	1wNbevDvDTQUOg8OBBF8Zymxh430kOYA+HVIZ3DvgoKUE4G8qfef/09i69lBEM8wJxoC+58RU0E
	vmZk78l+O4m8jzV42l8DRtVadWrvlQvRPUwd5rnwEB97ljzIoP1yZnmZww==
X-Google-Smtp-Source: AGHT+IGf9wJpKPB8sOAif2cBapevtQFgZEdOvFtRWa5cgAStYv1CeTH/1WOTDBZFxqFzQq9JOq6DIw==
X-Received: by 2002:a05:6000:4282:b0:38d:d0ca:fbad with SMTP id ffacd0b85a97d-39c120dededmr10748348f8f.14.1743508665067;
        Tue, 01 Apr 2025 04:57:45 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a42a3sm14130150f8f.91.2025.04.01.04.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 04:57:44 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: netfilter-devel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>
Subject: [PATCH v3 0/3] netfilter: Make xt_cgroup independent from net_cls
Date: Tue,  1 Apr 2025 13:57:29 +0200
Message-ID: <20250401115736.1046942-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes from v2 (https://lore.kernel.org/r/20250305170935.80558-1-mkoutny@suse.com):
- don't accept zero classid neither (Pablo N. A.)
- eliminate code that might rely on comparison against zero with
  !CONFIG_CGROUP_NET_CLASSID

Michal Koutný (3):
  netfilter: Make xt_cgroup independent from net_cls
  cgroup: Guard users of sock_cgroup_classid()
  cgroup: Drop sock_cgroup_classid() dummy implementation

 include/linux/cgroup-defs.h | 10 ++++------
 net/ipv4/inet_diag.c        |  2 +-
 net/netfilter/Kconfig       |  2 +-
 net/netfilter/xt_cgroup.c   | 26 ++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 8 deletions(-)


base-commit: dd83757f6e686a2188997cb58b5975f744bb7786
-- 
2.48.1


