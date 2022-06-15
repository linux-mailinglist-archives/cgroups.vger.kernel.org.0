Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF4A54C530
	for <lists+cgroups@lfdr.de>; Wed, 15 Jun 2022 11:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245608AbiFOJxz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Jun 2022 05:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbiFOJxx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Jun 2022 05:53:53 -0400
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2BE49B53
        for <cgroups@vger.kernel.org>; Wed, 15 Jun 2022 02:53:52 -0700 (PDT)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-fe4ac3b87fso15837471fac.3
        for <cgroups@vger.kernel.org>; Wed, 15 Jun 2022 02:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AUKE76wXieEn+TXiJ4E/8i8ZuBgufwhH+pRb5w1bivY=;
        b=dZxtWxCl7UU7qp8LcVZnmZNOPxPSBzxnyrIfbRBjVbqwwuXNn5e0un9QczoI9X6jDo
         oBh3Bg/KPha5TdkeB9C4oW5qjKtsG6SztzVJxGSx97uLqAST0bghULyUJlWZ/VZcRHhR
         kfGlcbpEbpIMnTDpDrfPh/IUed5VEUZ6l+vfMusjBsO8+ywtVcHbRXp74eyZCaFGcSf1
         aSwik2XrgmgA3JZXecNh1tMNViCr43JBWH6lqyRHEjWUXyFLoJDxXue6U8k47r9+oLNm
         Npgh0Pr7bEkdAj48MzspS1XiBxyherOuBAO7XLrolrGMP/terf2Uk5DteWk3jRjaOhUK
         IqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=AUKE76wXieEn+TXiJ4E/8i8ZuBgufwhH+pRb5w1bivY=;
        b=svdkfcjZGzXlACOO6yvW//eFIXhpKGAd011FIp8EDQ7mZYvqrEsgir3zGvqlDbwpGK
         gATyj8lGFj3Vspimh9+7MXiR8zc4msPGQaN+H8cAulDwipIf6qpe1/WSeAtvBVYndUz4
         vW8aHx2y1ejUZhlvkyVeMi5ULiLvzwPVfb4IQw7uSTKyytGMDHWMfEtVXxJGJ9SuxRci
         oMZ+vX1iT8YDCdjm1G2UypfkaT5x6J2bv71NOSh+RPcgvQdC0NEP03SwAPG0gswp75wl
         zG0kaFgtdvnfh02cQppwIv1RC7tZoJmS3sF2ITjeu1rzdMcJ2aSQ9P+HpJNfK/hcSX3Z
         Y7/g==
X-Gm-Message-State: AJIora8gK9ek6XAxXUyUH1lKs1aytaCmoLY81OduoL1LatK0U6R+UA8r
        JuIP0+OsphjRwPqKr3wGq2SdmPvF199Jjm1ETw0=
X-Google-Smtp-Source: AGRyM1s+gz24eomKRMZL47mERLKdcrAYv9s2Dc41zskzObMvg7lu6l+RY8jgJzFBv5ySSPWqUOUsItS5xqT447e5Epk=
X-Received: by 2002:a05:6870:5896:b0:e6:6c21:3584 with SMTP id
 be22-20020a056870589600b000e66c213584mr4955297oab.220.1655286831792; Wed, 15
 Jun 2022 02:53:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:3a01:0:0:0:0 with HTTP; Wed, 15 Jun 2022 02:53:51
 -0700 (PDT)
Reply-To: tescobank093.de@gmail.com
From:   Tesco Bank <tanabeshijoabbaje@gmail.com>
Date:   Wed, 15 Jun 2022 10:53:51 +0100
Message-ID: <CANsrtMcUr=mxZYkUUQSHFS3zTVkTw32++TzkB=rbLVD+p7Tekg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

--=20
Ben=C3=B6tigen Sie heute dringend einen Kredit, um eine Investition zu
t=C3=A4tigen? Ein neues Unternehmen gr=C3=BCnden oder Rechnungen bezahlen? =
Und
uns auf Wunsch in Raten zur=C3=BCckzahlen? Wir bieten Kredite zu einem sehr
niedrigen Zinssatz von 2% an. Wie viel Kredit m=C3=B6chten Sie und wie
lange brauchen Sie diesen Kredit???
      F=C3=BCr weitere Informationen antworten Sie auf unsere
E-Mail-Adresse: tescobank093.de@gmail.com
