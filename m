Return-Path: <cgroups+bounces-920-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBBD80F8F9
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 22:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773A3281F78
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 21:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADAA65A9E;
	Tue, 12 Dec 2023 21:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L4UAFUOZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DC7CF
	for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 13:17:44 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7b72d574399so254926139f.0
        for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 13:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702415864; x=1703020664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Zc6KTpAZSdY8QpoD6ndRxHT3SVEvXG+4LeuNbqJOvg=;
        b=L4UAFUOZAH3mEUJ0dYkraext6N+7dmrPBKQ07Zrkvg0EipGpro+00z8Kf/u6eTav0e
         ce0D3+DrURn7ueMVVDjugihrDkYrnlD+QKI9UKTbV2XHjM6LOsa7wtRs4TNUKXRf/Ei+
         Ofe/ZfWwt4z57P1hMbbpm/rviheqp6NahsHM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702415864; x=1703020664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Zc6KTpAZSdY8QpoD6ndRxHT3SVEvXG+4LeuNbqJOvg=;
        b=iq/YKmtj1PruGLE+OthPh0tRG/NIGiV6BsOQYj6zhPqzdeEgZIxyio8H5nSEUkZJ+G
         QPmK0/dpX+itziXoGYqMe1ECz8rJnx8RjxWPRzk+qRgJVQiDMB2sdOJP3/1NgXdapOUd
         APHjNFYCE7h9Yuz6HoIcQSK0JWasTyF9gSR3EJglhXWw+NlocOwpk50lmYrBJvjc+h0a
         MMYTB8SYGowWXpHQslwyhXN5uIyX0i3AXIo/CHU6AskIydIS7hfrK/zik+ury9q+euJr
         ogExJuYSC9fFQ3axACESp4E66bz62tqhuyKN6y+dMrxPt0Mj5cgqhMCkSEhdWHxDjNg4
         h2ww==
X-Gm-Message-State: AOJu0YzleZhUasECMdttAdjJER2qN6V8TXb65snLIB8urGKbQIYbsK8f
	oiedBp84Idkf3E7KJU1GjEMg7g==
X-Google-Smtp-Source: AGHT+IEvDlyQAlbj5kZpcUy0l69R3KnPJJrpfmKzdIY3kCQw6u1d63ztJ2FRYEW2wthGdpMi+t5zWQ==
X-Received: by 2002:a05:6e02:1526:b0:35d:59a2:2bb with SMTP id i6-20020a056e02152600b0035d59a202bbmr10427390ilu.91.1702415863911;
        Tue, 12 Dec 2023 13:17:43 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i4-20020a63cd04000000b005c1ce3c960bsm8681954pgg.50.2023.12.12.13.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:17:41 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Tejun Heo <tj@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 0/3] kernfs: Convert from strlcpy() to strscpy()
Date: Tue, 12 Dec 2023 13:17:37 -0800
Message-Id: <20231212211606.make.155-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=keescook@chromium.org;
 h=from:subject:message-id; bh=25MytgNAUZhUM008DbLRMGuucWR15FZ+JfVwwxo9GpI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBleM3zNEJ6ozMonZeoBQXI8on6XfsVYmsQsgluk
 o1wQ+Ga48OJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZXjN8wAKCRCJcvTf3G3A
 JsNPEACp/RHtIqnnV4mPRZIPFgXSZFVF1HvucA+ryrSi+/fpmEwvxufPyzuDwgNvNgXbvTi2AHk
 SyV/uJMDv/6gbhfFVhyvE60Wb0MqH5vRCJJkLHJjqd5QmFaLOZwMgbdsX0BkMhwE3sgnXH0+x/0
 rBmVvY+oMp2+nxQqmUeUCHg9v7ohxjEDc7cJUXQw1ohErQHEFgL/I3+etO2/t/XqLDC4b7/iZAW
 uCV5mIOpBOml+3+QYCaRLL5sIvpTOB8uzkgoELY+dOPfkH9qz0qTf6rW3lq/Hl8O756SsZdAf9s
 piPFzMgt6R6FoK+gsbWiO9pnRYVYVhXp6ZWdpx3zI4ftuMvbuqrfrrqRhAwt5igfahudw4qarQg
 npD/uktNC5EBbJc1DBbpHxukXKawE2ANI7oarahhLNx5r5hhSeW24mhApPa/Y4wz/Oo4to/4SqR
 C9JNMxmVvt3cIVjg1bq+4Z+qCQVzVEa5pJsYt1OvmtJXUonqsX8/8D2GSOFwReXk64SVsPoLIEl
 8V5SbrwZWj9Yswt1XA+josJR+CoAiZYQPNx2CbO5yc3xQNJNkg1bnVzy81o0+xQVtI/ZFtTit3n
 Ra2HxpF7JkjcUUDSwLJMq72OZMpGQ/NaMYcgjfrL+eD8X/C2kAShjRuuqk+UCSbcgiIA/+7ZknX
 KxURH9O 1QW+s3Sw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

One of the last users of strlcpy() is kernfs, which has some complex
calling hierarchies that needed to be carefully examined. This series
refactors the strlcpy() calls into strscpy() calls, and bubbles up all
changes in return value checking for callers. Future work in kernfs and
sysfs will see the replacement of open-coded string handling with the
seq_buf API, but we need to do one thing at a time.

Thanks!

-kees

v3: don't need to account for scnprintf() returning negative (christophe.jaillet)
v2: https://lore.kernel.org/all/20231130200937.it.424-kees@kernel.org/
v1: https://lore.kernel.org/linux-hardening/20231116191718.work.246-kees@kernel.org/

Kees Cook (3):
  kernfs: Convert kernfs_walk_ns() from strlcpy() to strscpy()
  kernfs: Convert kernfs_name_locked() from strlcpy() to strscpy()
  kernfs: Convert kernfs_path_from_node_locked() from strlcpy() to
    strscpy()

 fs/kernfs/dir.c           | 50 +++++++++++++++++++--------------------
 kernel/cgroup/cgroup-v1.c |  2 +-
 kernel/cgroup/cgroup.c    |  4 ++--
 kernel/cgroup/cpuset.c    |  2 +-
 4 files changed, 29 insertions(+), 29 deletions(-)

-- 
2.34.1


