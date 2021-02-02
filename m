Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A33130B5CC
	for <lists+cgroups@lfdr.de>; Tue,  2 Feb 2021 04:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhBBD0q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 Feb 2021 22:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhBBD0o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 Feb 2021 22:26:44 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ADEC061573
        for <cgroups@vger.kernel.org>; Mon,  1 Feb 2021 19:26:04 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id p15so18808368wrq.8
        for <cgroups@vger.kernel.org>; Mon, 01 Feb 2021 19:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=PrILWatQiBB/YexVPvDZsH566iBzGTKnf23zrhwD0wk=;
        b=ps9ovb/u5dicI1ClOpwpLYNIGOYZvAMTniiBNrnl02aPClI/Rvhfw1r4neh3IcYXQg
         vEp3ekFvG6h0u9Ecgvd/IrrGAj0pCkqYxPeRvvl4dko3snSN9MUx8Q0RC9HuV1NtGG4s
         svjCQkpq/x2xdqB2kpNgB5B56dS47McqshVDiQ6LSQQJMy32JQTyJfXZTeD2SJxQddWE
         1ndJrcu1qQRls6SNhSEQxVbfIXtHBQl3WA7SOpfhtWZyrCDkZGeyYsFyPeXqGXWBwxKp
         +vSe5Bg6Qws2FWV3zPcULPoUIVYu2UheZcqXpbPmLepOIYxo6jDgyFDdNKS1hNWxj0ou
         JKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=PrILWatQiBB/YexVPvDZsH566iBzGTKnf23zrhwD0wk=;
        b=XU8KRfLMfWJxKtINLX0F92e8Ym76mDzc+lhAzcAEJHcUbu/1+OY42/x1qDmtEtKtK7
         VYfOGKCeW9xb1e0kawKLh6TJGcQyJLCgmnCHRjAfM+YLK3IbxNPDQFp6Uh8y72ePI1kx
         PsveKFzcvsRHX0Fc+odL8NyQsqIIrxOQKIoXLf9UsKBKINc7N60PfQOaebhrY0C4zdFU
         UTN96TlmJUZEP6Fn0lpNnag03Be+F64/PlfZEPR1mkn3A7AXfinpKH2wwAblVhSxLskg
         WAayV6hy3bSq5ejUNBCEDZPDZ5I/6ebp+arnneAXMzgYtVn8NvrfU9eh+rHmPvTAYb8t
         1qoQ==
X-Gm-Message-State: AOAM532K9aibvBg2jYBqsuZojqkBo9hgzYRySYT+rJwhpYnt5tDDrex0
        I8JDgjrrk7kXIcY7CQv38Xs=
X-Google-Smtp-Source: ABdhPJy8BYFf8ly7GSFq8jgrKMxUgemzXbAaDWG5TLCmKEBPfUsCuxoVDWJgYsb2Hwi2aFtEEoOA6A==
X-Received: by 2002:a5d:4c84:: with SMTP id z4mr20634438wrs.289.1612236363125;
        Mon, 01 Feb 2021 19:26:03 -0800 (PST)
Received: from [192.168.1.8] ([41.83.208.55])
        by smtp.gmail.com with ESMTPSA id d2sm33414360wre.39.2021.02.01.19.25.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 01 Feb 2021 19:26:02 -0800 (PST)
Message-ID: <6018c64a.1c69fb81.f7f71.4019@mx.google.com>
Sender: Skylar Anderson <nguraneseydina82@gmail.com>
From:   Skylar Anderson <sgt.skylaranderson200@gmail.com>
X-Google-Original-From: Skylar Anderson
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: si
To:     Recipients <Skylar@vger.kernel.org>
Date:   Tue, 02 Feb 2021 03:25:53 +0000
Reply-To: sgt.skylaranderson200@gmail.com
X-Mailer: cdcaafe51be8cdb99a1c85906066cad3d0e60e273541515a58395093a7c4e1f0eefb01d7fc4e6278706e9fb8c4dad093c3263345202970888b6b4d817f9e998c032e7d59
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

esto es urgente / can we talk this
