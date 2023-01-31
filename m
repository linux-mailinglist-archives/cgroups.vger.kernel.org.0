Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DF5682C6B
	for <lists+cgroups@lfdr.de>; Tue, 31 Jan 2023 13:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjAaMS2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Jan 2023 07:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjAaMS1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Jan 2023 07:18:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FACA410B9
        for <cgroups@vger.kernel.org>; Tue, 31 Jan 2023 04:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675167464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0xKlxpkUZRo2mPicdjcp1VlQPa8+dcAbG4ZeEJrymiQ=;
        b=UWb42KNSY48B46V1kyvhV27kMAc4nZ595D9LQe5taP+PgDaO7D2er9ZyFJg8lJyWo7wZ4X
        5mOj/2dJgpltXjVIKsJnQ3FXKTm1H5HvxEnHLEOHfYFqMC0T1iI91q7O57dK159erG2GTw
        FlMg/urmObm75CH3hgxbWUFAnOLelYQ=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-551-9sMuzWqwN22yCLBjRKz1pA-1; Tue, 31 Jan 2023 07:17:43 -0500
X-MC-Unique: 9sMuzWqwN22yCLBjRKz1pA-1
Received: by mail-vs1-f72.google.com with SMTP id bm10-20020a056102510a00b003d0c2bdc78aso2936611vsb.12
        for <cgroups@vger.kernel.org>; Tue, 31 Jan 2023 04:17:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0xKlxpkUZRo2mPicdjcp1VlQPa8+dcAbG4ZeEJrymiQ=;
        b=gg8gQQCVs9H+Zg9dFiH7emjLZ8adgc3we3BkQlNZ/d/YOKaRbkR+BcEtviLL67H4XT
         qT/OMHzryh7jvFaYap+0sAndxvQ83ESf8Lba4Nq3+cZWF5YFCRNuZ0Ha6CrLmroZDT1l
         DcI5LvM9UL4iHQkFphkt5FTnG+ADz63JlwhFbqy1+bklRUPWaxkSGTZW/VXMVQKMj7a+
         qYa159aTRO66qb4+OaVDjrHdW31PfaO3gbSfE4pZzOnCVI8OaA6nV0IlcMCemlhKS7H1
         baaVYAs+qnHA2oNdhKFCC9iTIQQeXsa6HquIfVhRmO5eB5hpISqV4UWEFzZ/ZnMSdBBU
         JPlA==
X-Gm-Message-State: AO0yUKXUeQtnVCmRlRsPQjwrap0yMZKWkaCFAVuapv2V5N+boQVW+9vl
        bJACNwtyfKJDH6AnYH+ZGfxKNM8+f4a8dqO0xfsKnHm+2nY36WhCMWRrmiyQEnTQqqrTqwAxwr+
        LbT86ajtfkPsaeWnseA==
X-Received: by 2002:a67:c119:0:b0:3ea:99cb:c3e with SMTP id d25-20020a67c119000000b003ea99cb0c3emr2996511vsj.2.1675167462889;
        Tue, 31 Jan 2023 04:17:42 -0800 (PST)
X-Google-Smtp-Source: AK7set/3cWf1zFQSzSaXyTvYZFmhtrofj2WcZS5Lru0KQCl9i0U0TOY96Lm9fQ3ijteXPFUn2WOINw==
X-Received: by 2002:a67:c119:0:b0:3ea:99cb:c3e with SMTP id d25-20020a67c119000000b003ea99cb0c3emr2996457vsj.2.1675167462612;
        Tue, 31 Jan 2023 04:17:42 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-28.dyn.eolo.it. [146.241.113.28])
        by smtp.gmail.com with ESMTPSA id 10-20020a370b0a000000b007203bbbbb31sm3325683qkl.47.2023.01.31.04.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 04:17:42 -0800 (PST)
Message-ID: <865b04949b69c3470ecb3fa5f93005e4c5a9e86e.camel@redhat.com>
Subject: Re: [PATCH 0/9] Documentation: correct lots of spelling errors
 (series 2)
From:   Paolo Abeni <pabeni@redhat.com>
To:     patchwork-bot+netdevbpf@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org, agk@redhat.com,
        snitzer@kernel.org, dm-devel@redhat.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-mm@kvack.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, nvdimm@lists.linux.dev, vkoul@kernel.org,
        dmaengine@vger.kernel.org, song@kernel.org,
        linux-raid@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, jiri@nvidia.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rcu@vger.kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        sparclinux@vger.kernel.org
Date:   Tue, 31 Jan 2023 13:17:35 +0100
In-Reply-To: <167516701747.19012.10728935395396675001.git-patchwork-notify@kernel.org>
References: <20230129231053.20863-1-rdunlap@infradead.org>
         <167516701747.19012.10728935395396675001.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 2023-01-31 at 12:10 +0000, patchwork-bot+netdevbpf@kernel.org
wrote:
> Hello:
>=20
> This patch was applied to netdev/net-next.git (master)
> by Paolo Abeni <pabeni@redhat.com>:
>=20
> On Sun, 29 Jan 2023 15:10:44 -0800 you wrote:
> > Maintainers of specific kernel subsystems are only Cc-ed on their
> > respective patches, not the entire series. [if all goes well]
> >=20
> > These patches are based on linux-next-20230127.
> >=20
> >=20
> >  [PATCH 1/9] Documentation: admin-guide: correct spelling
> >  [PATCH 2/9] Documentation: driver-api: correct spelling
> >  [PATCH 3/9] Documentation: hwmon: correct spelling
> >  [PATCH 4/9] Documentation: networking: correct spelling
> >  [PATCH 5/9] Documentation: RCU: correct spelling
> >  [PATCH 6/9] Documentation: scsi/ChangeLog*: correct spelling
> >  [PATCH 7/9] Documentation: scsi: correct spelling
> >  [PATCH 8/9] Documentation: sparc: correct spelling
> >  [PATCH 9/9] Documentation: userspace-api: correct spelling
> >=20
> > [...]
>=20
> Here is the summary with links:
>   - [4/9] Documentation: networking: correct spelling
>     https://git.kernel.org/netdev/net-next/c/a266ef69b890
>=20
> You are awesome, thank you!

That is just a bot glitch. I actually applied only patch 4/9 to the
net-next tree. I hope this is not too much scarying/confusing.

Thanks,

Paolo

