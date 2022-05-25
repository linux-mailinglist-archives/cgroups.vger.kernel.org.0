Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B3B534478
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 21:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbiEYTpl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 15:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346188AbiEYToy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 15:44:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F4E66F8C;
        Wed, 25 May 2022 12:44:53 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso6089914pjg.0;
        Wed, 25 May 2022 12:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o70OUxKcTNYmgvPxndUPt88zZAQec5YsFXPWqk13pTk=;
        b=iQvt/SGuRVaZDmWBaBqGVRPz/Lr8OjhiODk2rCwVPKbsc4G0Fmry+yHyIpiUTxkxxZ
         bIsMnTXnwCQYmql/ykkMnZtXTr0qB9V838grdlfCMbYJ/W39snefOzCt0rjcwrGk52Yh
         lIiGnUE9ZdJ/YuoNk+OkLkdmah6JlT/Lk1DFbxrDmkHjXeCF9vnXdkZs/2BK4qBblk/Y
         UpqjteOfRRsUI8HrT/Pzd19YJWsjMfYCLbPh6HJ0wuMHo+hl1iyW0zAMFTmUZLm6tgdO
         pMSRg1V2mcfp0Rh1/CJz40fCxDp/XDR8JgWvFNpskDPJtVcoU8RBAifuinFKW3qPu+Yw
         CzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=o70OUxKcTNYmgvPxndUPt88zZAQec5YsFXPWqk13pTk=;
        b=WqQIHuseG8A3fnc+oTHsP0AgE7W2p011iP/sQ9s6ET+t4IrX/yQMLxBu6RTIsKT4hm
         6zwyeLYp+ei3JZUdLmOuPsmk5+6ltEbsKcUGmGt6iwJhBQFCotjKFFsgenQQZeVdmt3p
         9MidZq0fIOi1ltmH6vGFZnScZzVG/NeVafSftggzYv5pQCCVtcTk8y4EdoJeJceEB9jZ
         +J6Xmt3EZ4nVXWJhTY4jCC+RmFnT8p8+U09Qsgob8hyWL5asP9OHWoTHDHVOeoNzmHI7
         fj7majx1c7ngsJ4Fu3qperG8LH/oIvKLMDDedyNV02h404IigZV5w4GZqOT8weq7lqdU
         9XCg==
X-Gm-Message-State: AOAM53358hzEiGS43r9gkp6KHadL3ke/IK4m2hi0zJFGEwHnY+kKwTTX
        XFFVcmB1YX9et1KS1v8vttvGqCsQxUY=
X-Google-Smtp-Source: ABdhPJwbt6LcCDKFgTbH+LfFtahIgVM1PA7fvwZO7TjAexq341wBMHZKzlbBCN7kSs8pRDQYA6eZ6w==
X-Received: by 2002:a17:90a:fd91:b0:1e0:ca18:423c with SMTP id cx17-20020a17090afd9100b001e0ca18423cmr1632133pjb.48.1653507892549;
        Wed, 25 May 2022 12:44:52 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:aafd])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b0015e8d4eb25bsm9587582pln.165.2022.05.25.12.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 12:44:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 May 2022 09:44:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [GIT PULL] cgroup changes for v5.19-rc1
Message-ID: <Yo6HMpEodz36o4Dc@slm.duckdns.org>
References: <Yowcc/ZOBIIs2JtZ@slm.duckdns.org>
 <CAHk-=wiGsJgFTJ=yqYwWA2vcTWQy=2QQ6to6vd3ETutaE0cDxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiGsJgFTJ=yqYwWA2vcTWQy=2QQ6to6vd3ETutaE0cDxQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 25, 2022 at 12:43:09PM -0700, Linus Torvalds wrote:
> On Mon, May 23, 2022 at 4:44 PM Tejun Heo <tj@kernel.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.19
> 
> Your two pulls sadly broke the perfect signed tag streak that we had
> this merge window up until just now.
> 
> I'm very happy to see how people have started doing signed tags for
> everything, but that only makes your pull requests stand out even
> more.
> 
> So yeah, despite not requiring it for kernel.org pulls, I'd _really_
> like to make using signed tags just be the standard behavior for all
> the kernel pull requests.
> 
> Can we try to aim for that next time? Please?

Hahaha, yeah, I lost my private key many years ago, so gotta get that sorted
out first. Will do the signed pull from now on.

Thanks.

-- 
tejun
