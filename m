Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B043FD1EE
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2019 01:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKOA0X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Nov 2019 19:26:23 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:39328 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfKOA0X (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Nov 2019 19:26:23 -0500
Received: by mail-qt1-f182.google.com with SMTP id t8so8941354qtc.6
        for <cgroups@vger.kernel.org>; Thu, 14 Nov 2019 16:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=0tFAznP/o2VP74kg2CnbkybxNqllPHihT5bPzStJDZw=;
        b=gHpgVYE7BklA5dff+/FV7O0g+fRSURY17JLB+bDgYYI/ULYrMLGXLVtkDm3WaUmTzW
         3BJWsOf0KeIsLbFLz7WeJMYhF3EoWf2p5sGlaWaImptYaHx+nD/npZxIZ2bbxnuB9/Q7
         VnVasKuq9iGMAPrU2lcqF4mtbvEuwO4uOQ7wC5WEeh7f8fbVwVCpPdvFAt5SG9Ve9wPz
         6AGaX5Y17XDcMMX+gVtHiXtYgWY3eTueQ7KH+hbbz/pYkaf7+9vKm5LZLloba606odtZ
         bQY1BV7qU/IkcjkJ22KjAK66OwybBtbHJukxQ4pH6mbHCY7ywayi02S7CbKQ981R0aTM
         Vh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=0tFAznP/o2VP74kg2CnbkybxNqllPHihT5bPzStJDZw=;
        b=Iayg+KQyD/AdsgCQKQwtIiehDUE6eLuXJ+tK1TYFG9L/ama9qX5eE0yi7yEgKc+FB9
         cSqtxQz5wpVd3aGAiuZsoBdAFXssN3gwaLimBSAqE+dvkn/4LZDQc0xXRzdp8hSIm07G
         RaxLfxBARy/qFLD+x+QGxXk0T/rN8suYam4TEHl2tGq/hZnGQvj5TWNXL+RwsTu8+zNm
         nh8WOH0pjedBbumRL8S7L5CSKDGuJqoZdc6dvigeJReeERYrigQtdN2ZI1RrhMAPJSgl
         PWs+Si0uV1diDuj7frm/sDOEEr3YD9PgUNufgC2LFuwc2j9tyHfchUqKEW0rxazt60R7
         Z+WA==
X-Gm-Message-State: APjAAAUSNXvlkWLSjEKPWhgyXM5ENwxBrEr+o/icOZHsy2Y9ZnZv9VY/
        EmwwpAzSNacTrJwczWsUw2RFJQ==
X-Google-Smtp-Source: APXvYqyPWcdxmbDJkLh4PF4RYWC5w7LaBpYgd9hxKsutZWpQWgJEpJsKfIh6RuJQ4NDIuohgyYqCpA==
X-Received: by 2002:aed:3fc4:: with SMTP id w4mr11497978qth.120.1573777582450;
        Thu, 14 Nov 2019 16:26:22 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q8sm4302888qta.31.2019.11.14.16.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 16:26:21 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] writeback: fix -Wformat compilation warnings
Date:   Thu, 14 Nov 2019 19:26:21 -0500
Message-Id: <9D52EBB0-BE48-4C59-9145-857C3247B20D@lca.pw>
References: <20191114192118.GK4163745@devbig004.ftw2.facebook.com>
Cc:     jack@suse.cz, gregkh@linuxfoundation.org, cgroups@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org
In-Reply-To: <20191114192118.GK4163745@devbig004.ftw2.facebook.com>
To:     Tejun Heo <tj@kernel.org>
X-Mailer: iPhone Mail (17A878)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Nov 14, 2019, at 2:21 PM, Tejun Heo <tj@kernel.org> wrote:
>=20
> Acked-by: Tejun Heo <tj@kernel.org>

Tejun, suppose you will take this patch via your tree together with the seri=
es or should I Cc Andrew who normally handle this file?=
