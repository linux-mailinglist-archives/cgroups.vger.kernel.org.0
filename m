Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E544ADDF5
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 17:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiBHQH6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Feb 2022 11:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381929AbiBHQHx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Feb 2022 11:07:53 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDB1C061578
        for <cgroups@vger.kernel.org>; Tue,  8 Feb 2022 08:07:52 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p15so53631405ejc.7
        for <cgroups@vger.kernel.org>; Tue, 08 Feb 2022 08:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pxjwicyhltOLuF32btZSo9eR1Q86Q6QmMx6SaA/q3DI=;
        b=OB5f9v0kZYyeHeXgReydEaPOiq979JGQ7lVGZlZ6oerO1iBCCY1iWxu20iUkDgyoNe
         c1t/aUQ01QC+znccPD/jcIC+wwAm6hnUmmiy2z7kDF3cLJUMMmMFFRmeet/e3nBKQyEt
         Xk/CRe2LQ/RZ49l0q1BZsmQYAq4gFiek0EEZ+Z1ABV2rNhdhkyA1+kns7YAk3M7b+Lk8
         RLcZE0Sb0VvlEU2SZHdq0wbgunrryPSxZFiTgUDpR/sQS4gmOfV+oPD8RzV7YCzjALNT
         VMwocI/yT5E0Q0Vus3FHvHbYZ/1eK/o29ut25C0BmXinqyLPrMuZIx3hvWhJCDKkhxn2
         MAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=pxjwicyhltOLuF32btZSo9eR1Q86Q6QmMx6SaA/q3DI=;
        b=jdUo75r1NdmNL6zWn0bET4E148feMwMi8QH+C6xXjdE8flKsvsCDRYF5OrYoZiF0zD
         v4z9T0sF+EjiKS7uQYMlJxMNZPlKTmP7wn0yuIRF72L2N411zw7Tc7EIk4TAG7++6tmd
         z8EgQsVu2n045uZE5w53ZGhXluONPdhebd/JJfW0FaE/yQVR4mFG8iGhpQ0GDfZyZZB3
         wxzPTb993duX9RSakOrGyDD3bJlkr6/WU3c2F/7S4i57vb45OtnVW1Bn3AJ4tXkfo9DE
         OsvF2sySUZUiYgiBagxOrRfg8fxEGppnySiBrtHdc5u86MzG5En3tNJe2M3gasE/Jj0r
         a5Lg==
X-Gm-Message-State: AOAM533uHZULlhny83lwFYQcMBjrkBKCngTrry+zwUHNUEUCq/jeKizJ
        z5RAkS+qkbuo37qi4dAi/s5PHw==
X-Google-Smtp-Source: ABdhPJz4RnNuj5YY8xlIrK2+luOydjfdY6530XHJpbvHISffDI7nftfnB9s3FoY7gS9qnJyGCpXHFw==
X-Received: by 2002:a17:906:dc90:: with SMTP id cs16mr2272590ejc.295.1644336471256;
        Tue, 08 Feb 2022 08:07:51 -0800 (PST)
Received: from mbp-di-paolo.station (net-2-37-165-88.cust.vodafonedsl.it. [2.37.165.88])
        by smtp.gmail.com with ESMTPSA id a21sm4794976eds.5.2022.02.08.08.07.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Feb 2022 08:07:50 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3 2/3] block, bfq: avoid moving bfqq to it's parent bfqg
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <c85b10ce-fb41-9e0a-772a-63c226227207@huawei.com>
Date:   Tue, 8 Feb 2022 17:07:49 +0100
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <36E597B3-AC41-48CC-BF3D-C35FAA7CCDD6@linaro.org>
References: <20220129015924.3958918-1-yukuai3@huawei.com>
 <20220129015924.3958918-3-yukuai3@huawei.com>
 <c85b10ce-fb41-9e0a-772a-63c226227207@huawei.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 8 feb 2022, alle ore 04:53, yukuai (C) <yukuai3@huawei.com> =
ha scritto:
>=20
> =E5=9C=A8 2022/01/29 9:59, Yu Kuai =E5=86=99=E9=81=93:
>> Moving bfqq to it's parent bfqg is pointless.
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>  block/bfq-cgroup.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> Hi, Paolo
>=20
> I make a clerical error in last version of this patch:
>=20
> bfq_group should be bfqq_group
>=20
> Can you please take a look of this patch? I do compile and
> test the patch this time...
>=20

Haven't I acked this patch series already?

Thanks,
Paolo

> Thanks,
> Kuai

