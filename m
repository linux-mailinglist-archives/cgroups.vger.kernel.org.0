Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914AA6B1680
	for <lists+cgroups@lfdr.de>; Thu,  9 Mar 2023 00:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCHX1o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Mar 2023 18:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCHX1o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Mar 2023 18:27:44 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1218F305E5
        for <cgroups@vger.kernel.org>; Wed,  8 Mar 2023 15:27:43 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cw28so166632edb.5
        for <cgroups@vger.kernel.org>; Wed, 08 Mar 2023 15:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678318061;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1zWOMPSvNv1W+Brwx3O5hoQNy7UbuBHYVJzIEpneeA=;
        b=BxbIC6u8DggW0qfqNBFlf4ypBDElVDni2smDRryCHafKIbK5liSeb/uCPkjcaxfT9G
         pWKsl1tf8zJMNjndM06GIclbgG1okMbLVi+dfqALX1rGQzoUvKsNd4YXK6If/cG1o0mB
         I8GCskZrWcN0gg5GV6q4VpxJhQSOY78Pts5EIMKTXQd8H5IpCdFH8Zyy9SgnLK2bHdcf
         STwF0pH9Xudz2F3zdShWVLItR8bgMUIXplYFB8ZD6D+ICT9GzPAH2LiaZsWYJbdwMArg
         508bUmaJJnclb8a2wK0C1G/ew4UC7MsuaPgJDarK4RvujkZVdSvUa+VUrUz2MPCEa5z7
         HBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678318061;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1zWOMPSvNv1W+Brwx3O5hoQNy7UbuBHYVJzIEpneeA=;
        b=LMNJjWvBr+v8AxEm57n+4aEsQ6c71EwYT1y/35R519jRD6UKonKnieP3Xr6G+bFYwc
         OTxBx+HJF4nL8byBTMn2dagVnv8SXme7CkbhJVCu//M2WQHI3JJbCjStuaiN2l7fj1d9
         ctmuvW/Zv23HyWrG7S6VEVvegn79vXAw0jAQD92rEfz5eg3MNgaVEFF0bu2Rtqk6lJDb
         ODI8l9RC+2nC5F6bqzPNpSiMKst2PYt3TfhzqPDAi/6vimIhOG8zXbt0NMXj5lQakrTD
         bQQ4vS444fi0eB8TBhe+wucLmd9scgJzGvpIrEgOwvs5jdgaHOyfj+TtJZ0d3C4eyu4Z
         6+8w==
X-Gm-Message-State: AO0yUKXW90cXyOhS1qNghdtO3FDLsWr5zfEv/h6P6xh1fiXHaZTGue7b
        C8E/Mb6cSnhiX1XcZllhFiE6vm7kZN6vg0sW6Ek=
X-Google-Smtp-Source: AK7set/nED47xKHAyBGtEfZW7/J3yBTo7ywGC7yNvdm3J4YI7iMw+C2f29aj1xfVLRtbdYjuwEk0iojt6ZVf/4T23kA=
X-Received: by 2002:a17:906:a1c5:b0:8f0:147b:be2 with SMTP id
 bx5-20020a170906a1c500b008f0147b0be2mr9296415ejb.4.1678318061557; Wed, 08 Mar
 2023 15:27:41 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:907:d08e:b0:8ec:2fbd:ee49 with HTTP; Wed, 8 Mar 2023
 15:27:41 -0800 (PST)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <usfinancialdepartment0120@gmail.com>
Date:   Wed, 8 Mar 2023 23:27:41 +0000
Message-ID: <CAAH0rABHDSCPn89DyWQpYMYJnqXPtaMQ49yv8MAKnMaC=RWJJg@mail.gmail.com>
Subject: re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [usfinancialdepartment0120[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [usfinancialdepartment0120[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

-- 
Dear Friend,

I am Mr.Thaj Xoa from Vietnam and I have an important message from you.

Regards
Mr Thaj Xoa
