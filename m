Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 006301D037
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2019 21:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfENTzZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 May 2019 15:55:25 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:45837 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfENTzY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 May 2019 15:55:24 -0400
Received: by mail-lf1-f50.google.com with SMTP id n22so120208lfe.12
        for <cgroups@vger.kernel.org>; Tue, 14 May 2019 12:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+EChwP3DKYPjI5XpqLSr6oJaGwq6Bw/jcFqJ7qh2lsQ=;
        b=igzbEp2IBA0V1G3i5KexoIr6AO7cZ0Jy6zct23dG+XxrZdkA3EmPSSySACPnAgsd/h
         vyRrEfQlVFiSyzHcnQoEZf3kyVMbDrbI54rPwkT4BOBr9x3+/E02Tmanj6YQYBC1Mqkq
         ss2fY+p9cGpWsoaFEp1h6kwGB7lp2PMVkekWnzId82TDdPa50oMglmC9KOuvT0l8PKUr
         fToaXM0oZTl8UrPcrHRAH5xnJIhlEGr8m4vc7lwYCpvheN4TEv2cgfT3LrQYP/FIlaM6
         r63fKZImyMQhNEgfBalN1Jv6vpMwPD4p/1gQrcay9tn40qUIU1E6JZ3dFsd/RLa3WIYs
         wiOw==
X-Gm-Message-State: APjAAAU5sLH9V82xspDTmvpd6oYC6D4GAU6vb9OfJ6N7bHTNxqUVePiW
        8KK790EmAhRv8ezhM4Wzwra9azGdGJkShc5M6r9c4w==
X-Google-Smtp-Source: APXvYqzxWurvWfE/jtG7ZrK+iKrHqkmi1/rs7MROPXi7/n09L/1Rs/Rv4bP09a59natdMGzyV3Pd9g86srvzsidCM0o=
X-Received: by 2002:ac2:5621:: with SMTP id b1mr18829823lff.27.1557863722997;
 Tue, 14 May 2019 12:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnkfhwMSNm4uSkcGtqaGmYanfNK9rx6m2a3TqJh08YitbGAUg@mail.gmail.com>
 <20190514194249.GD12629@tower.DHCP.thefacebook.com>
In-Reply-To: <20190514194249.GD12629@tower.DHCP.thefacebook.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Tue, 14 May 2019 21:54:46 +0200
Message-ID: <CAGnkfhxwP1SwJLv2E-6Xd7ZXN8XUPRyXkM=tB0Z=jre8Rij6=A@mail.gmail.com>
Subject: Re: WARNING: CPU: 1 PID: 228 at kernel/cgroup/cgroup.c:5929
To:     Roman Gushchin <guro@fb.com>
Cc:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Roman,

yes, this one fixes it.

-- 
Matteo Croce
per aspera ad upstream
