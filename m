Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D303522AC6
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 06:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiEKEXv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 May 2022 00:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiEKEXt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 May 2022 00:23:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39003CA44
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 21:23:44 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x88so1110326pjj.1
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 21:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=w3fXqagdV6ARWiDPbvkyYPAzxiQLdd0lCJMoPe8dDH8=;
        b=Pch7rUAX9MCFHwpyAmxNkr2ncZrpmjVnG3PJyHPXfeoV8bBDEhn4M5b511U3rmVjDE
         1KfLMR9ecbDaur4edmblJUwf3XACVoedhMLWt44eFpLgIVcy8TY2rcPyCnZz+hEc2dmi
         K1dxC+E6PazMsWc0fdeSLrmWumJn2mtt76ldwGmGc1YoRKejeaAuk22T+nySst7hzdjN
         zUOlZYnOrybLBbSTtjgW4LEBQczXV7cLpWMppFwvx1gMaEAxjQkgUTcf5qTF6WKc36q8
         0z80z/JS91a3ruCNENGazKCp8YRFd5flXSS/QfdgfEveATAAtoKwCTrvaJtljR+49IzX
         wNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=w3fXqagdV6ARWiDPbvkyYPAzxiQLdd0lCJMoPe8dDH8=;
        b=qkrgb+WDRhtl2yTSjCk4aimL1seJYEymksodUT96c7mkHGc0tSG70tcjpabcmKGzCF
         Z3jG2aQt3Xx/pspCXobWVIkUMXhOv1u+EnN7eb9HCuBMxILfGk9m5erMdiojtSR7Q279
         JoqIwgn1q4uu5qQZempUDRJnzpzhyOrlPEXyGLCJhF/RR+OaaHp56NHHDHfpHbjkMnOg
         mC51e2SW8HvTYiZxHd9U08sWrDmDsxQ5BcZByILZ8QeF+MBCPC9PhNNTtrir0h11bap/
         hGCVjLXZXo/V4qXpi+d9slU+QAt7CdNqUo6vR1GYp3LzhEYOJh0AQCqAfK5B/Gq0z3kr
         fYbw==
X-Gm-Message-State: AOAM5335eCADhitux4nDqWjBe794PPA9WENydfztBTH7cZ0jeJZ6CEHV
        Qi2F3gIpKnwBmob7QA44jLYO9PkK5X1DFD2K7QM=
X-Google-Smtp-Source: ABdhPJxJs4nzuMfmP5boS0ffSAaXLrKDqKBvj1kNXu+C/kyS+OgFPM9tmbftl48ZHJmbTXOKZdnM0ko7/vFVBTvBZMs=
X-Received: by 2002:a17:90b:1007:b0:1dc:9862:68af with SMTP id
 gm7-20020a17090b100700b001dc986268afmr3213093pjb.205.1652243024210; Tue, 10
 May 2022 21:23:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:319:0:0:0:0 with HTTP; Tue, 10 May 2022 21:23:41
 -0700 (PDT)
From:   Private Mail <privatemail1961@gmail.com>
Date:   Tue, 10 May 2022 21:23:41 -0700
Message-ID: <CANjAOAg_uGZV8_euUey_BjE4C4EPi5QC0MAi_q-Qe+oZ-iQbfg@mail.gmail.com>
Subject: Have you had this? It is for your Benefit
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=ADVANCE_FEE_4_NEW_MONEY,
        BAYES_50,DEAR_BENEFICIARY,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,
        LOTS_OF_MONEY,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Our Ref: BG/WA0151/2022

Dear Beneficiary

Subject: An Estate of US$15.8 Million

Blount and Griffin Genealogical Investigators specializes in probate
research to locate missing heirs and beneficiaries to estates in the
United Kingdom and Europe.

We can also help you find wills, obtain copies of certificates, help
you to administer an estate, as well as calculating how an estate,
intestacy or trust should be distributed.

You may be entitled to a large pay out for an inheritance in Europe
worth US$15.8 million. We have discovered an estate belonging to the
late Depositor has remained unclaimed since he died in 2011 and we
have strong reasons to believe you are the closest living relative to
the deceased we can find.

You may unknowingly be the heir of this person who died without
leaving a will (intestate). We will conduct a probate research to
prove your entitlement, and can submit a claim on your behalf all at
no risk to yourselves.

Our service fee of 10% will be paid to us after you have received the estate.

The estate transfer process should take just a matter of days as we
have the mechanism and expertise to get this done very quickly. This
message may come to you as a shock, however we hope to work with you
to transfer the estate to you as quickly as possible.

Feel free to email our senior case worker Mr. Malcolm Casey on email:
malcolmcasey68@yahoo.com for further discussions.

With warm regards,

Mr. Blount W. Gort, CEO.
