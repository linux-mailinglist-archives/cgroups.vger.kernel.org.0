Return-Path: <cgroups+bounces-2133-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E4C88628E
	for <lists+cgroups@lfdr.de>; Thu, 21 Mar 2024 22:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EB4284504
	for <lists+cgroups@lfdr.de>; Thu, 21 Mar 2024 21:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F1E135A7D;
	Thu, 21 Mar 2024 21:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b="qOM3fsm6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B87134CEF
	for <cgroups@vger.kernel.org>; Thu, 21 Mar 2024 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711056789; cv=none; b=fKe133gVO25vi42KXt+FxTYCU8Fb6/qgbRKuX10KBFMCgdHq8IAn1nC9SP1Ri2eCFdSzjjujrtoxkc3it5NxH79aKtnF21MCXZzFmq6/lzVbjcdLEtqB4di2C5ir/iZdH7FK67ECLRzK+IydOYdX5RATHEKslWoeLbwRRXl5Mks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711056789; c=relaxed/simple;
	bh=s/aigHywVhgWNsDVTBDV12Yn4U7cENsqLjO7yKIRaVU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Yb4PU31vKC+x6rZFk/EUmwp1XgsScCwjIlGCHAXZAme2afQYMmdEl5Pu5e3DjqfImeKB57HEm4h7Z6GIE5SHcJw1lHSmUmJF57MIe0P6j+XieEEnA115tNQOVp2wYCMwEDQASwPqMibFiNHctA6KRCWVHkhw0Ydrmw42v+zw/bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz; spf=none smtp.mailfrom=malat.biz; dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b=qOM3fsm6; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=malat.biz
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so19839051fa.3
        for <cgroups@vger.kernel.org>; Thu, 21 Mar 2024 14:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1711056784; x=1711661584; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZByuXS+qgZa7z4y4pS++q8CS2lDsMnE9E32aeKsq3tQ=;
        b=qOM3fsm6gPH/Xivf0FtSYNw7e6u6GhNRnze/+h6COL4JTq7sOfxFjoPXXk5K5QMN/z
         L0/UggbxiuqPyVnRZWEgIg1n+3ukr1JgJePqU8ELn/an//0PwEtk5JJfzlwsTQudrY5f
         MMp09UNAlkQx+juoAv5qPZZHqDtZj10YPbEvKZKa1mScMTrb/DIfWCJpkApTT5NMjqQE
         7YBxTFoXWc2pZlRTaz0rAUCMVqiEMGkbPMfJS68jD3opZQMHBcc4VfJL1QFd/8RmyzWN
         yLdo1H3WCeFTQm3VG+O4dYHUlPYVntzuiQJZIf/7C2UdH6ckKWiYm7ruUMM97Ce2H2Hn
         OcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711056784; x=1711661584;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZByuXS+qgZa7z4y4pS++q8CS2lDsMnE9E32aeKsq3tQ=;
        b=Km7Gq21nB5fW2zCReqw77acEr+D6Q9eS2C5HllW9RUNV5u0s9Fih8lUASm1qUIGmVO
         ZodviQLlIVn6ov0Crs6CSOmEaiwBqpFnkhv6G1xByIRGJEDucM9p1y/5b4ZAO8YJSTxi
         plp6a3g3ls7tsvbbhc//Fw5NetuScOeLQUI3IrgBmjjPWiqnySPsuR+z007zf01oOZKG
         gyzcTLCKyCkw5rLQ+QJg6kD0hJ0Ue2qjLyPxXGpb1zDshgDBc7aaNv6ImATIyGl1xqOc
         gYEoGUvba6zHtMBA8Xenj7Xh5BsXlxGdJGqhc/L1rWWpQT0/TO24NJ+YeiYmaOlifd13
         /MuA==
X-Gm-Message-State: AOJu0YyzwGh4RkBmeW6A/VaD8GpJvjoITSxlgi3QEi/osJktOerOW15u
	oeDiYQczPKdsFATaeqLZS3Fij6fdma2csewtdVwZZbiVOsYgRGJNaU8DKYJtvK+PwckMKVo0gQt
	JCA==
X-Google-Smtp-Source: AGHT+IFXD8RPKQD/5Mezpj6PH4jKtlm+xSxfT8sOzwsyFtWZtTPaPoV07RUHdR/BEWf9sS/9SgAyaA==
X-Received: by 2002:a2e:9397:0:b0:2d4:49d2:a3d1 with SMTP id g23-20020a2e9397000000b002d449d2a3d1mr562717ljh.1.1711056784301;
        Thu, 21 Mar 2024 14:33:04 -0700 (PDT)
Received: from ntb.petris.klfree.czf ([193.86.118.65])
        by smtp.gmail.com with ESMTPSA id t31-20020a056402241f00b0056bb1b017besm281322eda.23.2024.03.21.14.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 14:33:03 -0700 (PDT)
Date: Thu, 21 Mar 2024 22:33:03 +0100
From: Petr Malat <oss@malat.biz>
To: cgroups@vger.kernel.org
Cc: longman@redhat.com, tj@kernel.org
Subject: [RFC/POC]: Make cpuset.cpus.effective independent of cpuset.cpus
Message-ID: <Zfynj56eDdCSdIxv@ntb.petris.klfree.czf>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
I have tried to use the new remote cgroup feature and I find the
interface unfriendly - requiring cpuset.cpus.exclusive to be a subset
of cpuset.cpus requires the program, which wants to isolate a CPU for
some RT activity, to know what CPUs all ancestor cgroups want to use.

For example consider cgroup hierarchy c1/c2/c3 where my program is
running and wants to isolate CPU N, so
 - It creates new c1/c2/c3/rt cgroup
 - It adds N to cpuset.cpus.exclusive of rt, c3 and c2 cgroup
   (cpuset.cpus.exclusive |= N)
 - Now it should do the same with cpuset.cpus, but that's not possible
   if ancestors cpuset.cpus is empty, which is common configuration and
   there is no good way how to set it in that case.

My proposal is to
 - Not require cpuset.cpus.exclusive to be a subset of cpuset.cpus
 - Create remote cgroup if cpuset.cpus is empty and local cgroup if it's
   set, to give the user explicit control on what cgroup is created.

I have prepared change to test my idea (the next mail). I haven't tested it
thoroughly yet, but I wanted to open the discussion on this topic to know
if such a change could be accepted and I should burn more time on it.

BR,
  Petr

