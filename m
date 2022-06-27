Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D15455D949
	for <lists+cgroups@lfdr.de>; Tue, 28 Jun 2022 15:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiF0Gt1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jun 2022 02:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiF0GtY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Jun 2022 02:49:24 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7D9C11
        for <cgroups@vger.kernel.org>; Sun, 26 Jun 2022 23:49:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j21so14945866lfe.1
        for <cgroups@vger.kernel.org>; Sun, 26 Jun 2022 23:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jB9gmLMPTj46OngTeaDoiv6CEvUyIMLR8V7jwVzji04=;
        b=FC6ETplDrOSrvKwinUtNxD54YXyc1Tqr5kU/AHTxIqhiecrK8dLL0Buj583oTUDfBT
         x32T5x0pbVTqQwo0kPnIYpBqjx0tbwH8f74480tzNPj24NqzVX2kNKUl8IHxJ2zlTe8A
         9zWG0tXAmmNpmy2F3QDERfa/yKDcFuoCGv6w5yZOO/bTPCozu4QLFDUf0MK1/1FPa3In
         wO6R725pJJ7Z3OlOeABc1wL+pdv/CcmXNVMce062QhR0ur3HPu0RHKTP4bh+bgfxh/Jx
         IZCgDPgOcn6Mq+i+OAIznu6URXW/rdI3w0X8dJT3x9miytTnfhAD6sj3hihCmxXJHx+Q
         ZRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jB9gmLMPTj46OngTeaDoiv6CEvUyIMLR8V7jwVzji04=;
        b=IRRAAeJ0UHdZ7VKZhD8hT2YLaFH/53TZPBQyrpPiUBPf3n+uJKl1oEyTTOWhetM9Vy
         M4fjrHuuyEyGahSnHQkq8R8UgpfcOsmYz5aMLMeEckWggmE2G4mXlOfwv/+Kj23Z99VI
         5wvvX1dDCHOSoRHxnv642+OR4YrzVbGRIST9mmJXHgXQVlxpSW1IoJe859LfT+3+PPng
         /vsUf56vkwzcBbzZKE6XA6kRG2JW30KFUW565LZif1lNkXpM2IQyZ2Odu7vdm+eRwoxL
         ew721feYiV7RNPO3EoOPwOEIrCuIsVlkiaZjg3WGvfWGYrxcZNGkeHNOgXyn2tbfSrPB
         T/CA==
X-Gm-Message-State: AJIora8CdJtcGk2qYVH7zgjFoSez0Bi1gpkElv/KAtT0JfOKWkyJrObB
        qQ//BDa8qrLG9Fo1jpil4npeYg==
X-Google-Smtp-Source: AGRyM1sM6tpzoBZ6tC5pcfi1SX3LclsBzlCc0hFeeoPkOvsFhG1IUa0XGOKStU0B7Psoe06QCH4QEQ==
X-Received: by 2002:a05:6512:2390:b0:481:6f3:2de7 with SMTP id c16-20020a056512239000b0048106f32de7mr6403105lfv.497.1656312560374;
        Sun, 26 Jun 2022 23:49:20 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id p26-20020ac246da000000b0047f797dcbd1sm1672606lfo.189.2022.06.26.23.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 23:49:19 -0700 (PDT)
Message-ID: <f3e4059c-69ea-eccd-a22f-9f6c6780f33a@openvz.org>
Date:   Mon, 27 Jun 2022 09:49:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH mm v2] memcg: notify about global mem_cgroup_id space
 depletion
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Michal Hocko <mhocko@suse.com>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Cgroups <cgroups@vger.kernel.org>
References: <Yre8tNUY8vBrO0yl@castle>
 <97bed1fd-f230-c2ea-1cb6-8230825a9a64@openvz.org>
 <CAMZfGtWQEFmyuDngPfg59D-+b9sf58m9qhGoVPSQ_jAGmgT+sg@mail.gmail.com>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <CAMZfGtWQEFmyuDngPfg59D-+b9sf58m9qhGoVPSQ_jAGmgT+sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/27/22 06:23, Muchun Song wrote:
> If the caller can know -ENOSPC is returned by mkdir(), then I
> think the user (perhaps systemd) is the best place to throw out the
> error message instead of in the kernel log. Right?

Such an incident may occur inside the container.
OpenVZ nodes can host 300-400 containers, and the host admin cannot
monitor guest logs. the dmesg message is necessary to inform the host
owner that the global limit has been reached, otherwise he can
continue to believe that there are no problems on the node.

Thank you,
	Vasily Averin
