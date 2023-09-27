Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C64D7AF87C
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 05:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjI0DM2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Sep 2023 23:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjI0DK1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Sep 2023 23:10:27 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7969830F1;
        Tue, 26 Sep 2023 19:28:24 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-65cff6a6878so848366d6.1;
        Tue, 26 Sep 2023 19:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695781703; x=1696386503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwhbVww0wcBV3klKpARDGOKUJ4usm35gWsWhGhKfqAc=;
        b=bEOPxKLESruQ7xzgbp4Z7NcyhKdEcmW1e1/Z4pQyIgFe5OghrvVEKrOBnUrxtmPd6G
         9UyB0jvJklOlQGiCYI/CTzlwbPFltSyI98e9y1ShnRDIjaCKDDdfHa2Lya/89FUrsDLC
         G2357Naty0CXZ3kW05wXrApoZcyXrDqRwjQkqhbv+DqyUQosuj0AGMaCUiH3IrInkWh9
         oUZmb07o0164x2kQADA5h0x+/3qCp6GhYQdK6DSY8BmV9FfAceC77fTVA3mZAWc8qocc
         tcetejOCkQsqmMDpuTsUveS4zHIm51Npjb/Syzkuj2VKRcLrfclLgpSXJJ6Ksm8GuPKG
         LP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695781703; x=1696386503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwhbVww0wcBV3klKpARDGOKUJ4usm35gWsWhGhKfqAc=;
        b=Ibc0PAJTT48OgFq0VEZoaWw+XiuXa4O2nAzf/JAU2xnGFc9Ty5w+pAfLWmNq+kdyfM
         nA52xtdE7R4xxfyH9/csud5hfUxUPW1qCP8Ldq3QKDUkR9imncSAHK7CmSvLUQZT5RsA
         0jghiN+qwajyhoX4B6xb0T2/RL7O8hcX8ia2DCMULHlVZllXKxMWpLnbRYwpk0zTypi6
         80bajs3KHsyOvUPMBEnpTx+hHeArSKe2AoUoE6oCawcyGEsZUxGO7+VPTe8K1yz9R6SX
         v+WPAQ5tyQTWjxkVRxQvnFwMX5Bh6QUOuzBn3Pu1/su/nYyX5EiFt11+h+3Efc9hr7f1
         lWpQ==
X-Gm-Message-State: AOJu0YwY+AYGdiWjzZgBA/W809zHRG39X9WJcNTyoBdKxpXdUgk8QolA
        ZV0cmquwTOgJoV8jNty/nI7cAch15zl1OEMR0Ac=
X-Google-Smtp-Source: AGHT+IGisiVyVc/yKQ9U3V+vdNt5CNfFKoG7T3Tb3+PoGa7BJbYwunMdqZqKFB9WBvPcsbkHB3Ye2s9ICk524NdF3JU=
X-Received: by 2002:a0c:e185:0:b0:65a:4189:f0f7 with SMTP id
 p5-20020a0ce185000000b0065a4189f0f7mr744041qvl.46.1695781703572; Tue, 26 Sep
 2023 19:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230922112846.4265-1-laoar.shao@gmail.com> <ZQ3GQmYrYyKAg2uK@slm.duckdns.org>
 <CALOAHbA9-BT1daw-KXHtsrN=uRQyt-p6LU=BEpvF2Yk42A_Vxw@mail.gmail.com>
 <ZRHU6MfwqRxjBFUH@slm.duckdns.org> <CALOAHbB3WPwz0iZNSFbQU9HyGBC9Kymhq2zV83PbEYhzmmvz4g@mail.gmail.com>
 <ZRMiDwYF8yDookLf@slm.duckdns.org>
In-Reply-To: <ZRMiDwYF8yDookLf@slm.duckdns.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 27 Sep 2023 10:27:47 +0800
Message-ID: <CALOAHbAkBxbAxXLBHuJo_6nJZAwnUv2258a5Rw9g=76bSoLe6Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/8] bpf, cgroup: Add bpf support for cgroup controller
To:     Tejun Heo <tj@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
        cgroups@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 27, 2023 at 2:25=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Sep 26, 2023 at 11:01:08AM +0800, Yafang Shao wrote:
> > Thanks for your suggestion. I will think about it.
> > BTW, I can't find the hierarchy ID of systemd (/sys/fs/cgroup/systemd)
> > in /proc/cgroups. Is this intentional as part of the design, or might
> > it be possible that we overlooked it?
> > In the userspace, where can we find the hierarchy ID of a named hierarc=
hy?
>
> Yeah, /proc/cgroups only prints the hierarchies which have controllers
> attached to them. The file is pretty sad in general. However,
> /proc/PID/cgroup prints all existing hierarchies along with their IDs and
> identifiers (controllers or names). Hopefully, that should be enough?

Right, /proc/self/cgroup can show the hierarchies. Thanks for your explanat=
ion.

--=20
Regards
Yafang
