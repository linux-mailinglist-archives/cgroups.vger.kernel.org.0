Return-Path: <cgroups+bounces-5969-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3029F77EE
	for <lists+cgroups@lfdr.de>; Thu, 19 Dec 2024 10:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1BE163096
	for <lists+cgroups@lfdr.de>; Thu, 19 Dec 2024 09:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F22521D008;
	Thu, 19 Dec 2024 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fb18mEtd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D597E217701;
	Thu, 19 Dec 2024 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734599205; cv=none; b=ZFNOTmDtrAckTaXWRh/LrUSc4NtFZSmp3kxtCPkyfJUW/8gVHN3NMJ1AGZH2g/BjhnGUC/CCsMEtlLw+gmJm53J7/ZP+H9N3bDZx42x1mOgmu1MPYMlJy8UJPoUfRPvElNFld9hn/q7xtjux3QHIbAKK2md0Ndl48hR5YlvRcUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734599205; c=relaxed/simple;
	bh=Vn30QdUjyjitwwTgP+jes9R7D0iGO0ShgDeCkkNh3wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ua2cUK6rMEHmwbRihBHqYz4thayd9CoBzXI0V0PuMiBw1mAxfwyZkIynZ2I16FlWcCnyurnF3U+3o+q1dnQX4AOJleXE6QVs4bh1Dbxmjc4oCz+6eujjgmGy+p1QrXkGD1RN5+HrtdRy7Lc+kdHEqVe60jHhOmOyXS0WIa37mkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fb18mEtd; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5187cd9b8e5so182083e0c.1;
        Thu, 19 Dec 2024 01:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734599202; x=1735204002; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QHiK9fskyTYOOX6zSOFELlublwgep+6d+Yhkjq9LnIs=;
        b=Fb18mEtdFqNwz1uzJauxd83Ym8+xt3v7wWxX87CNXg08gPre8iuDV7hRlgrxCNqFP9
         J/tMPq+gJcUiFS0o5cNBKqJ5yh8zx6dz0VJGWRbd3H8gaL4sdNjXkV7rvrIdchMiwi3a
         KJ30oRdym7dfEYbSn15/rBbo/Lm5uuvhsiT8FLjFsnbE4VbmNvrgwcfyoBhIUbKvk09c
         zPu9O3OsVkFPPw9o0tAHrGK+/IpGoWrlHwvQNICbV72rHA1LXi9FQZFnJfF0Yzu7hhfr
         uzRJjCpM89I/Z6GJWrbztU8XA2Rx6is6BtP2oaeZvGeKUNOiuRMJe82A5qDYsLufKLoz
         7F6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734599202; x=1735204002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHiK9fskyTYOOX6zSOFELlublwgep+6d+Yhkjq9LnIs=;
        b=vEWaR9hgRcYchBKT0po43xVle3OS956wY/ynpGdVSVp6X1a3iMX2otYwfEt7pD5YAC
         KHO5tNiyVVyoxGT8g+410g3gMhd43D8L9GLQ/ktkVEg2CglMPSoUFtKUzqjENIbrsmLB
         jnUZrUZn14n01ZhjBSnqrl6EBEMfQHL9/rkMHxZH7an/h4S4hVnEHgOaPX1JdtmAxfXQ
         RLP1MWMb2vHqI+8whY15y6LlrJbMndvUVuj1Wa90ZGRvC2u9Y49036Gbi1+2DwHW4FJB
         NkggGnNwDrxJP3ClI6zpw17CiK0OMPHhPu4eSYSjAP9/sO5KvVUGRVJw/HFEdPigVZTZ
         ZdTA==
X-Forwarded-Encrypted: i=1; AJvYcCUbUTrtLX/aMIvcS8kKOhFc5YOg5lYcvWqbk1C61LRf1IkuWc/HR1hJ2PkkqklGIC6U+UBmo/CR7CgiwUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0EveKq4pqtSUebvZZPFUVx8+h3K/Z+A+GiVIEyXEjm4wsp+Zi
	qxkBVKVxyz/G/ArUgvv9PObQM76uSYnxIkEYTC/4CS/RKzezTCeDonMPRr/44QgYyeSAszJZRPN
	/1d6Ml6rRY/3BQPVxMGtVqq8qsU9Mk0V6z3IrYA==
X-Gm-Gg: ASbGnctBamXVkScOdN8maIYsPpAhSdC3NbHgQRdIMXGHT0sGv8g0DZhAI5x+RpMl8oa
	NblStcyH2R937esqKE4aGtvS5I/TnH3KcLPEgj88=
X-Google-Smtp-Source: AGHT+IEHr3DCVj5vuOCgVW/3QT5KvwH9xUrEvMeTmla1JjewPi0lu1DQfPMCeuEKoBXAiLrVb/VoSFNIInjVVncnevc=
X-Received: by 2002:a05:6122:1688:b0:515:d38a:e168 with SMTP id
 71dfb90a1353d-51a36c70b0amr5722925e0c.4.1734599202664; Thu, 19 Dec 2024
 01:06:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4f605f58-4658-40a2-afc2-e1f24d11e79e.jinguojie.jgj@alibaba-inc.com>
In-Reply-To: <4f605f58-4658-40a2-afc2-e1f24d11e79e.jinguojie.jgj@alibaba-inc.com>
From: Jin Guojie <guojie.jin@gmail.com>
Date: Thu, 19 Dec 2024 17:06:31 +0800
Message-ID: <CA+B+MYRNsdKcYxC8kbyzVrdH9fT8c2if5UxGguKep36ZHe6HMQ@mail.gmail.com>
Subject: [PATCH] cgroup/cpuset: fmeter_getrate() returns 0 when
 cpuset.memory_pressure disabled
To: Waiman Long <longman@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When running LTP's cpuset_memory_pressure case, the following error occurs:

(1) mount a cgroup v1 hierarchy, enable cpuset, set memory limit
(2) write 1 to memory_pressure_enabled
(2) create a process in this group, allocate a large amount of memory
    to generate pressure
(3) write 0 to memory_pressure_enabled
(4) immediately read cpuset.memory_pressure:
    the kernel returns a non-zero value, and LTP determines it as FAIL

According to admin-guide/cgroup-v1/cpusets.rst,

"1.5 What is memory_pressure ?
 ...
  So only systems that enable this feature
  (i.e. memory_pressure_enabled) will compute the metric."

To be consistent with the documentation, when memory_pressure_enabled is 0,
cpuset.memory_pressure should always returns 0.

Signed-off-by: Jin Guojie <guojie.jin@gmail.com>
---
 kernel/cgroup/cpuset-v1.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 25c1d7b77e2f..940beff47772 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -105,8 +105,15 @@ static int fmeter_getrate(struct fmeter *fmp)
        int val;

        spin_lock(&fmp->lock);
-       fmeter_update(fmp);
-       val = fmp->val;
+       if (cpuset_memory_pressure_enabled) {
+               fmeter_update(fmp);
+               val = fmp->val;
+       } else {
+               fmp->cnt = 0;
+               fmp->val = 0;
+               fmp->time = 0;
+               val = 0;
+       }
        spin_unlock(&fmp->lock);
        return val;
 }
--
2.34.1

