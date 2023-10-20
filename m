Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E4C7D0C13
	for <lists+cgroups@lfdr.de>; Fri, 20 Oct 2023 11:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376893AbjJTJhv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Oct 2023 05:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376687AbjJTJhq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Oct 2023 05:37:46 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C6010D7;
        Fri, 20 Oct 2023 02:37:35 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so618461276.0;
        Fri, 20 Oct 2023 02:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697794654; x=1698399454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGNznPsTVL7r5fUa5yWmdKYSl0/KhU2hv+FsOhhScWo=;
        b=JiTtqSmBStovt7DmeKHC561o4kInk0apC+iCBGiyhY/T3ascnn6eWkxHBx9XQC/zLd
         bVqm0QbR8oElEQtLEPZ8COk815znOfhVq4xmmMti6bgfw9wUk9kWfaxm9QbWVsjwATH0
         XnK5mR+EYg0yQQ7fSoe3+lWNSSb6tRQacavh4wcRDz+XEA5gL/DB/jPYO++4IRDTM4+T
         34DwQlSLPonU3Vo74YwpzAYi6EC/cmStYhMCWXYma3C3F0SHHiW3NpHf9Aw9HcUQrAbT
         5Csy74desv/DYFdIdOE7sEmnwaagM7RIcIxAkvuzlumsw8LKTSysovrF8pgLwAQcWOT9
         NwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697794654; x=1698399454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGNznPsTVL7r5fUa5yWmdKYSl0/KhU2hv+FsOhhScWo=;
        b=Etm/ttRgGE3ZQ3aa7Ndv8bNYgJOGX4kZIGex3Iurpp5V3kir+jnCbVacJYr+PAz5/B
         oBOntxF40uFtOV1RtPjh4DeiWs2X8AEbuhPEqPLuqKqE0dgMyBb61RTe8YFIVskafuyF
         NRqOCN5bNbwO0ucXnNEsi7Om89qChgAIaUobeh5MyYuPsL57JnR6duVlfgavhcgRz+C3
         fRCv66yI1rtAC8eb8n/YH+D3Wwhfkyc/lvtEz0URu3HxxnSnztTlkL+SUPkFwzdR+oUb
         yhCJbHpOEc7U2AEqaBfRHsAWVX0CZ3yG2rqLW3JndSnx/qVmBOvVIOltspW6vt/3ceDv
         E+Cg==
X-Gm-Message-State: AOJu0YwO2NMuA5V1u5U51oXsgyDwNkgofk/xIxY3XpnzbKqhNkLHbq6W
        Ino7DNZ5ZopdpzKYU/7eaj21VL8nSmyARRapfY0=
X-Google-Smtp-Source: AGHT+IG45bJOjz9sD7TDzCQos0POliQ9zNVRh7Po5jlTj3N60hg5OTy5if7qevLpsU7vXKm+0dqWVm7YQW2MCx4Tv2w=
X-Received: by 2002:a25:8c88:0:b0:d9c:44:4463 with SMTP id m8-20020a258c88000000b00d9c00444463mr1070424ybl.34.1697794653908;
 Fri, 20 Oct 2023 02:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231017124546.24608-1-laoar.shao@gmail.com> <20231017124546.24608-2-laoar.shao@gmail.com>
 <ZS-m3t-_daPzEsJL@slm.duckdns.org> <CALOAHbAd2S--=72c2267Lrcj_czkitdG9j97pai2zGqdAskvQQ@mail.gmail.com>
 <ZTF-nOb4HDvjTSca@slm.duckdns.org> <09ff4166-bcc2-989b-97ce-a6574120eea7@redhat.com>
In-Reply-To: <09ff4166-bcc2-989b-97ce-a6574120eea7@redhat.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 20 Oct 2023 17:36:57 +0800
Message-ID: <CALOAHbDO=gzkn=7e+6LMJNwKUPxexJfg=L1J+KZG9a9Zk9LZUg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 1/9] cgroup: Make operations on the cgroup
 root_list RCU safe
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, yosryahmed@google.com,
        mkoutny@suse.com, sinquersw@gmail.com, cgroups@vger.kernel.org,
        bpf@vger.kernel.org
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

On Fri, Oct 20, 2023 at 3:43=E2=80=AFAM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 10/19/23 15:08, Tejun Heo wrote:
> > On Thu, Oct 19, 2023 at 02:38:52PM +0800, Yafang Shao wrote:
> >>>> -     BUG_ON(!res_cgroup);
> >>>> +     WARN_ON_ONCE(!res_cgroup && lockdep_is_held(&cgroup_mutex));
> >>> This doesn't work. lockdep_is_held() is always true if !PROVE_LOCKING=
.
> >> will use mutex_is_locked() instead.
> > But then, someone else can hold the lock and trigger the condition
> > spuriously. The kernel doesn't track who's holding the lock unless lock=
dep
> > is enabled.
>
> It is actually possible to detect if the current process is the owner of
> a mutex since there is a owner field in the mutex structure. However,
> the owner field also contains additional information which need to be
> masked off before comparing with "current". If such a functionality is
> really needed, we will have to add a helper function mutex_is_held(),
> for example, to kernel/locking/mutex.c.
=E3=80=81
Agreed. We should first introduce mutex_is_held(). Thanks for your suggesti=
on.

--=20
Regards
Yafang
