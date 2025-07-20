Return-Path: <cgroups+bounces-8790-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5F2B0B48C
	for <lists+cgroups@lfdr.de>; Sun, 20 Jul 2025 11:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A1317A55E
	for <lists+cgroups@lfdr.de>; Sun, 20 Jul 2025 09:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E161E32DB;
	Sun, 20 Jul 2025 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b="sNi+PwGs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail0.khirnov.net (red.khirnov.net [176.97.15.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B913D1C3C11
	for <cgroups@vger.kernel.org>; Sun, 20 Jul 2025 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.97.15.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753002964; cv=none; b=XwX7Pzuj+tQ37vFY/wUsUlmil64MSzngGU1bljS9SfgOXURX6sSDAUIfNP5cwUSPI6KBajNSfJ+6OyCWocj/2oYuSQts8jo0ovNwxV31eMw5v/4T+JUewHuOnJhCVTmPBWozMVXk2RuniEKdzAYq17lWVQUwUd+pjwn7dqxB8rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753002964; c=relaxed/simple;
	bh=8flOhJZEDY+lIikEaMWIydk5O/GdiUsx99uY442viQc=;
	h=Content-Type:From:To:Subject:Date:Message-ID:MIME-Version; b=Ycy1Vmi11DKH8Txvi9HBjtVVEZVIEaT5WV09CkbfGGOCjd4qpqbsEtTezJRD+TDH34N1n26RwSDzKq0ifo57liRE/m1r7UeEimTFH9ne9UIU7u8MEQ3XM9DOjrFAKSCs5lSkWZTFwPcNqG5W5zybum68+REEYI4uB2TnMEDcV1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net; spf=pass smtp.mailfrom=khirnov.net; dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b=sNi+PwGs; arc=none smtp.client-ip=176.97.15.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khirnov.net
Authentication-Results: mail0.khirnov.net;
	dkim=pass (2048-bit key; unprotected) header.d=khirnov.net header.i=@khirnov.net header.a=rsa-sha256 header.s=mail header.b=sNi+PwGs;
	dkim-atps=neutral
Received: from localhost (localhost [IPv6:::1])
	by mail0.khirnov.net (Postfix) with ESMTP id 950452446C1
	for <cgroups@vger.kernel.org>; Sun, 20 Jul 2025 11:15:49 +0200 (CEST)
Received: from mail0.khirnov.net ([IPv6:::1])
 by localhost (mail0.khirnov.net [IPv6:::1]) (amavis, port 10024) with ESMTP
 id r1YSATu79lJe for <cgroups@vger.kernel.org>;
 Sun, 20 Jul 2025 11:15:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=khirnov.net; s=mail;
	t=1753002947; bh=8flOhJZEDY+lIikEaMWIydk5O/GdiUsx99uY442viQc=;
	h=From:To:Subject:Date:From;
	b=sNi+PwGsqzvcLsMbzvT+gaFRGgg5kMzfV5rcC86pUWR+plWuC+AQzQ+n7XYBdADOO
	 aLN1fEGlkhvVsmEknvodLZZA/JIh6mrcJSs3dAIc+J3f1B72q/43p0MTsBfGIyPe+j
	 vCbiD4Kw1DjRNTqFi3Kqti7NgfTaP6Zm9aVxCtgfpqjaU6GZI7LK/cS8+NuVnackFF
	 QWzn66Bne4SEkVuB2ynquWszQUdYNTsuQR9u94M6aVOPCJsEgUmqST/5FU+18dqXIo
	 0ukDXan8Ml8wxsbgIv1vk0JyNUA5/DnopQDjz4OanONd00349GQujTmJOQ9Lj6i0hp
	 +H82MqJfI14Vw==
Received: from lain.khirnov.net (lain.khirnov.net [IPv6:2001:67c:1138:4306::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "lain.khirnov.net", Issuer "smtp.khirnov.net SMTP CA" (verified OK))
	by mail0.khirnov.net (Postfix) with ESMTPS id 5E5902446B9
	for <cgroups@vger.kernel.org>; Sun, 20 Jul 2025 11:15:47 +0200 (CEST)
Received: by lain.khirnov.net (Postfix, from userid 1000)
	id 3ED571601BA; Sun, 20 Jul 2025 11:15:47 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:  Anton Khirnov <anton@khirnov.net>
To:  cgroups@vger.kernel.org
Subject:  unexpected memory.low events
Date: Sun, 20 Jul 2025 11:15:47 +0200
Message-ID: <175300294723.21445.5047177326801959331@lain.khirnov.net>
User-Agent: alot/0.8.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,
I have a machine with a bunch of LXC containers and a pure v2 cgroup
hierarchy mounted with memory_recursiveprot. The hierarchy looks
roughly like this:
/lxc/
/lxc/pam
/lxc/containers/
/lxc/containers/init.scope
/lxc/containers/lxc.{monitor,payload}.<container>

I want to protect processes in one of the containers from being swapped
out, which I tried to achieve by setting memory.low as follows:
/lxc/            - 512M (amount available for all the children)
/lxc/containers/ - max  (just propagate parent value to children)
/lxc/containers/lxc.payload.<protectedcontainer> - 512M

memory.low in every other cgroup is 0. I would expect that with this
setup the anon memory in <protectedcontainer> would not be swapped out
unless it exceeded 512M. However, what actually happens is:
* the 'low' entry in memory.events under <protectedcontainer> goes up
  during periods of high IO activity, even though according to
  documentation this should not happen unless the low boundary is
  overcommitted
* the container's memory.current and memory.swap.current are 336M and
  301M respectively, as of writing this email
* there is a highly noticeable delay when accessing web services running
  in this container, as their pages are loaded from swap (which is
  precisely what I wanted to prevent)

Does this look like a problem with my understanding of the docs, or my
configuration?

I'm running the 6.12.27-1~bpo12+1 Debian kernel, in case it's relevant.

Cheers,
-- 
Anton Khirnov

